From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] ST DDC I2C U300 bus driver v3
Date: Wed, 20 May 2009 15:30:57 +0200
Message-ID: <63386a3d0905200630v187187d5j84ec4bafadf69539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Changelog v2->v3:

* Documented the stu300 struct with kerneldoc.

* Use resource_size_t for resource base and size struct
  members so it will work on 64bit ranges if need be.

* Clarified that this device require that you use 32bit
  bus access when reading and writing registers, even
  though they are actually 8bit.

* Fixed error message when trying to poll for events
  with interrupts disabled, and converted to a
  WARN() clause since this is serious stuff.

* Add MODULE_ALIAS() to the platform device name.

* Various error messages and whitespace/alignment fixes.

Are you happy with this one now Ben?

Yours,
Linus Walleij
