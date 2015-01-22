From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-tools: add compatibility for python2/3 to py-smbus
Date: Thu, 22 Jan 2015 11:49:58 +0100
Message-ID: <20150122114958.3178f5f6@endymion.delvare>
References: <CA+TH9VkT1K2aqAuNOLsGiU407OA4NYcMVaUakEQgSWLpMBBg2A@mail.gmail.com>
	<20150119230327.0224d0ba@endymion.delvare>
	<1421917018.21840.0@smtp.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421917018.21840.0-YAXBhf1W29QAs8EywTwl9A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>
Cc: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi again Michael,

On Thu, 22 Jan 2015 09:56:58 +0100, Michael Mercier wrote:
> I just tried you patch and I got an error when I try to import the 
> smbus python package:
> 
> import smbus
> 
> ImportError: 
> /usr/local/lib/python3.2/dist-packages/smbus.cpython-32mu.so: undefined 
> symbol: i2c_smbus_process_call
> 
> Any idea?

Hmm, OK, I think I see what's going on here.

There are two i2c-tools branches: the stable branch (3.1) and the
development branch (SVN trunk.) The patch I sent was for the
development branch.

One important difference between the two branches is that, in the
stable branch, the i2c API is implemented as a set of inline functions,
while in the development branch it is a library. I don't think that
py-smbus was properly ported so most likely it was already broken
before my patch. I suppose you are using SVN trunk and this is why you
have this linking problem?

If that is the case, then maybe the following patch will do the trick:

---
 py-smbus/Module.mk |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- i2c-tools.orig/py-smbus/Module.mk	2012-04-26 12:05:55.351086796 +0200
+++ i2c-tools/py-smbus/Module.mk	2015-01-22 11:47:06.524806243 +0100
@@ -12,7 +12,7 @@ PY_SMBUS_DIR := py-smbus
 PYTHON ?= python
 DISTUTILS := \
 	cd $(PY_SMBUS_DIR) && \
-	CPPFLAGS="$(CPPFLAGS) -I../include" $(PYTHON) setup.py
+	CPPFLAGS="$(CPPFLAGS) -I../include" LDFLAGS="$(LDFLAGS) -Llib -li2c" $(PYTHON) setup.py
 
 all-python: $(INCLUDE_DIR)/i2c/smbus.h
 	$(DISTUTILS) build

But please keep in mind that my python knowledge is non-existent so it
might be plain wrong. Hopefully Angelo can comment on this.

-- 
Jean Delvare
SUSE L3 Support
