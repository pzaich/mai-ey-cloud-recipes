bash "install_graphics_magick" do |variable|
	user "root"
	cwd "/tmp"
	code <<-EOH
	wget ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/1.3/GraphicsMagick-1.3.15.tar.gz
	tar -xvf GraphicsMagick-1.3.15.tar.gz
	cd GraphicsMagick-1.3.15
	./configure
	make
	sudo make install
	EOH
	not_if do
		'command -v gm'
	end
end