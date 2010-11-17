//libraries
var fs = require('fs'),
    path = require('path');

//constants
var MAX_SPAWN = 200; //used to control how many simultaneous files should be opened at a given time

//config

// var data_path = "data",
//     list_pages_folder = data_path + "/list_albums",
//     albums_folder =  data_path + "/albums";

var data_path = "../abrcrawl2_data/data",
    list_pages_folder = data_path + "/html/list_albums/first_2010_02_12_asc",
    albums_folder =  data_path + "/html/albums";

//globals
var albums = {},
    album_timestamps_progress,
    album_photos_progress,
    open_files_count = 0,
    execution_queue = [];

/*
Scan a folder containing the cached HTML files of album list pages and extract
the Title and Timestamp information from there. Updates the albums associative
array passed as second parameter.
*/
function getAlbumsTimestamps(list_pages_folder, albums){
  //run through the albums subfolders
  fs.readdir(list_pages_folder, function(err, subdirs){
    var i = 0, 
        list_page_path = '';
        album_timestamps_progress = 0 + subdirs.length;
    if (err) throw err;
    for (i = 0; i < subdirs.length; i = i + 1){
      filename = subdirs[i];
      //legal folder names are starts with a number
      if (/^[0-9]/.test(filename)) {
        list_page_path = path.join(list_pages_folder, filename);
        //run through all files to find the cached html
        fs.readdir(list_page_path, function (err, files){
          var cached_html_filename,
              html_file_path;
          if (err) throw err;
          cached_html_filename = findFirstCachedHTML(files);
          html_file_path = path.join(this.list_page_path, cached_html_filename);
          fs.readFile(html_file_path, function(err, data){
            if (err) throw err;
            extractAlbumsTimestampFromHtml(data, this.albums);
          }.bind({albums:this.albums}));
        }.bind({list_page_path:list_page_path, albums:albums}));
      } else {
        album_timestamps_progress = album_timestamps_progress -1;
      }
    }
  });
}

function extractAlbumsTimestampFromHtml(html, albums){
  var date_id_and_title_pattern = new RegExp("<span class=\"data\">([^<]*)</span>[^<]*<h3>[^<]*<a href=\"[^\"]*%3Fid%3D([^\"]*)\">([^<]*)<\/a>", "g"),
      html = html.toString(),
      matches,
      album_id;
  while (matches = date_id_and_title_pattern.exec(html)){
    album_id = matches[2];
    if (! albums[album_id] ){
      albums[album_id] = {};
    }
    if (matches[1]) {
      albums[album_id].date = matches[1];
    }
    if (matches[3]) {
      albums[album_id].title = matches[3];
    }
    date_id_and_title_pattern.lastIndex = matches.index + matches[0].length
  }
  album_timestamps_progress = album_timestamps_progress -1;
  if (album_timestamps_progress === 0) {
    getAlbumsPhotoLists(albums);
  }
}

function getAlbumsPhotoLists(albums){
  album_photos_progress = 0;
  for (album_id in albums){
    album_photos_progress++;
    execution_queue.push({f:getAlbumPhotoLists, params:[album_id, albums]})
  }
  resumeQueue();
}

function resumeQueue(){
  var task;
  if (execution_queue.length > 0){
    if (open_files_count < MAX_SPAWN) {
      open_files_count++;
      task = execution_queue.pop();
      task.f.apply(this, task.params);
      resumeQueue();
    }
  }
}
function getAlbumPhotoLists(album_id, albums){
  var album_folder_path = path.join(albums_folder, album_id);
  fs.readdir(album_folder_path, function (err, files){
    var cached_html_filename, 
        html_file_path;
    if (err) throw err;
    cached_html_filename = findFirstCachedHTML(files);
    html_file_path = path.join(this.album_path, cached_html_filename)
    fs.readFile(html_file_path, function(err, data){
      if (err) {
        if(err.errno === 24){
          console.log('ERROR: Too many open files, try using a lower value for the MAX_SPAWN variable at the beggining of this script source file.')
        }
        throw err;
      }
      extractAlbumPhotolistFromHtml(data, this.albums, this.album_id);
      open_files_count--;
      if (open_files_count < MAX_SPAWN) {
        resumeQueue();
      }
    }.bind({albums:this.albums, album_id:this.album_id}));
  }.bind({album_id:album_id, album_path:album_folder_path, albums:albums}));
}

function extractAlbumPhotolistFromHtml(html, albums, album_id){
  var pattern = new RegExp("<li[^>]*#urls_foto([^\']*)'[^>]*>[^<]*<img[^>]*title=\"([^\"]*)\"", "g"),
      html = html.toString(),
      matches,
      photos = {},
      photo_id;
  while (matches = pattern.exec(html)){
    photo_id = matches[1];
    photos[photo_id] = {};
    if (matches[2]) {
      photos[photo_id].caption = matches[2];
    }
    pattern.lastIndex = matches.index + matches[0].length
  }
  albums[album_id].photos = photos;
  album_photos_progress = album_photos_progress -1;
  if (album_photos_progress === 0) {
    console.log('finished')
    // console.log(JSON.stringify(albums));
  }
}

function findFirstCachedHTML(files){
  var cached_html_filename = '';
  files.forEach(function (filename) {
    if (/^[^\.]/.test(filename)) {
      cached_html_filename = filename;
    }
  });
  return cached_html_filename;
}
console.log('processing...')
getAlbumsTimestamps(list_pages_folder, albums);
