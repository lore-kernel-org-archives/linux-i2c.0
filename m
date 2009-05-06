From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] ST DDC I2C U300 bus driver v2
Date: Wed, 6 May 2009 15:16:19 +0200
Message-ID: <63386a3d0905060616u563aed60i8b134044078f099f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Updated patch for this driver, please tell me if it's good enough
enough for mainlining now...

Changelog v1->v2:

* Renamed from i2c-stddci2c to i2c-stu300, also in function
  prefixes and module name (so as not to confuse when tracing
  kernel calls).

* Removed all unnecessary #include <> directives.

* Replaced 8bit accessor macros with inline functions.

* Replaced all pr_debug() with proper dev_dbg() calls.

* Moved clock settings over to a table lookup.

* Introduced more documentation especially of state machine
  events. Described as far as the documentation goes.

* Clarified that zero-length messages are unsupported.

* Introduced more linespacing in terse sections to ease
  readability.

Yours,
Linus Walleij
