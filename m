From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] MFD: Add U300 AB3100 core support v4
Date: Wed, 20 May 2009 11:16:13 +0200
Message-ID: <63386a3d0905200216q209849e4wd4f2b73d06c74be0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ChangeLog from v3 -> v4:

* Set parent to the AB3100 subdevices properly.

* Some brace placement fix-up.

* Error print on main struct allocation failure.

* Remove register range definitions for subdevices
  for the time being. It's unclear if IORESOURCE_IO
  is applicable for this usecase. No other MFD devices
  do this anyway.

* Remove machine-specific debug flag requirement for
  this driver to expose debugfs. This can be used on
  other machines so CONFIG_DEBUG_FS.

Yours,
Linus Walleij
