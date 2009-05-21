From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] MFD: Add U300 AB3100 core support v5
Date: Thu, 21 May 2009 23:15:53 +0200
Message-ID: <63386a3d0905211415r3c83c24ftbf2b140139573f56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ChangeLog from v4 -> v5:

* Remove the singleton pattern. Now we can instantiate
  several AB3100 chips on the same system if we want to,
  this won't happen in practice but it makes the driver
  look more similar to other drivers so it's nice.

* Consequently pass around the struct ab3100 * token
  instead of using the local singleton inside the
  driver.

* Replace all "ab3100_data" suffixes on variable
  names with a plain "ab3100" since there is not
  difference between these anymore.

* Pass a small struct to the get/set register debugfs
  functions in order to pass mode of operation as well as
  a pointer to a struct ab3100 * in the file private data.

* Correct file permissions on write-only debugfs files.

* Hoping that Sam will accept this into the -mfd tree...


Yours,
Linus Walleij
