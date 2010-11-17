
Agencia Brasil URL structure (as of November 15, 2010):

List Albums page (pages 1-164)
http://agenciabrasil.ebc.com.br/ultimasfotos?p_p_id=galeria&_galeria_railsRoute=%2Fgerenciador_galeria%2Fgaleria%3Fpage%3D[PAGE_NUMBER]

Show Album (album ids 96-1828)
http://agenciabrasil.ebc.com.br/ultimasfotos?p_p_id=galeria&_galeria_railsRoute=%2Fgerenciador_galeria%2Fgaleria%2Fshow%3Fid%3D[ALBUM_ID]

Image URLs (photo id 812-14139)
http://agenciabrasil.ebc.com.br/galeriaimagens/images/fotos/[PHOTO_ID]/[small|normal|high]?p_p_id=galeria

---------------------------------------
List Albums page HTML hooks:

<span class="data"> [DATE] </span> <h3> <a href="http://agenciabrasil.ebc.com.br/ultimasfotos?p_p_id=galeria&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_galeria_railsRoute=%2Fgerenciador_galeria%2Fgaleria%2Fshow%3Fid%3D[ALBUM_ID]">[ALBUM_TITLE]</a>

---------------------------------------
Show Album page HTML hooks:

…<h4>[ALBUM_TITLE]</h4>…
…<img alt="Small?p_p_id=galeria" src="http://agenciabrasil.ebc.com.br/galeriaimagens/images/fotos/[PHOTO_ID]/small?p_p_id=galeria" title="[PHOTO_TITLE]" />…
…<p class="nav">

----------------------------------------

= REQUIREMENTS

- bash
- wget
- imagemagick


= (C) and LICENSE
== Code
(c) Fabricio Zuardi 2010
MIT license

== Pictures
(c) Agencia Brasil
Creative Commons Atribuição 2.5 Brasil http://creativecommons.org/licenses/by/2.5/br/

=== Snippet from http://agenciabrasil.ebc.com.br/ footer (as of November 15, 2010) in Portuguese

“Todo o conteúdo deste site está publicado sob a Licença Creative Commons Atribuição 2.5. Brasil.””
