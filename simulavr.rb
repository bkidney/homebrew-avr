require 'formula'

class Simulavr < Formula
  homepage 'http://savannah.nongnu.org/projects/simulavr/'
  head 'https://github.com/Traumflug/simulavr.git'
  url 'http://download.savannah.gnu.org/releases/simulavr/simulavr-1.0.0.tar.gz'
  sha1 'e7cacc74be974793bd9c18330ec8d128fbd17d42'

  depends_on 'jpommerening/avr/avr-binutils'
  depends_on 'jpommerening/avr/avr-libc'
  depends_on 'jpommerening/avr/swig-1.3'

  if build.head?
    depends_on 'autoconf'
  end

  def patches
    patchdir = path.realpath.dirname.to_s

    unless build.head?
      [ patchdir + '/patches/simulavr-1.0.0-resize.patch' ]
    else
      [ patchdir + '/patches/simulavr-HEAD-glibtool.patch' ]
    end
  end

  def install
    multios = `gcc --print-multi-os-directory`.chomp
    binutils = Formula.factory('jpommerening/avr/avr-binutils')

    if build.head?
      system "./bootstrap"
    end

    system "./configure", "--with-bfd=#{binutils.opt_prefix}/#{multios}-apple-darwin13.0.0/avr",
                          "--with-libiberty=#{binutils.opt_prefix}/lib/#{multios}",
                          "--prefix=#{prefix}",
                          "LDFLAGS=-lz"
    system "make"
    system "make install"
  end
end
