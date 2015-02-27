require 'formula'

class Simulavr < Formula
  homepage 'http://www.nongnu.org/simulavr/'
  head 'https://github.com/jpommerening/simulavr.git'

  depends_on 'avr-binutils'
  depends_on 'avr-libc'

  if build.head?
    depends_on 'libtool'
    depends_on 'autoconf'
    depends_on 'automake'
    depends_on 'swig'
  end

  def patches
    patchdir = path.realpath.dirname.to_s

    if build.head?
      [ 'file://' + patchdir + '/patches/simulavr-HEAD-gtest.patch' ]
    end
  end

  def install
    if build.head?
      system "./bootstrap"
    end

    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
