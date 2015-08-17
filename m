From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Mon, 17 Aug 2015 15:09:45 +0200
Message-ID: <20150817130945.GE7537@lunn.ch>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch>
 <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150816131130.GC10094@lunn.ch>
 <1511754934.28154.1439739426390.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <55D1DB24.8090602@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D1DB24.8090602-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 17, 2015 at 02:01:24PM +0100, Srinivas Kandagatla wrote:
> 
> +Adding Maxime in the loop
> 
> On 16/08/15 16:37, Stefan Wahren wrote:
> >>>Another question which spring to mind is, do we want the eeprom to be
> >>>in /sys twice, the old and the new way? Backwards compatibility says
> >>>the old must stay. Do we want a way to suppress the new? Or should we
> >>>be going as far as refractoring the code into a core library, and two
> >>>wrapper drivers, old and new?
> >I think these are questions for the framework maintainers.
> >
> One of the reasons for the NVMEM framework is to remove that
> duplicate code in the every driver.  There was no framework/ABI
> which was guiding such old eeprom sysfs entry in first place, so I
> dont see an issue in removing it for good. Correct me if am wrong.

The reason for keeping it is backwards compatibility. Having the
contents of the EEPROM as a file in /sys via this driver is now a part
of the Linux ABI. You cannot argue it is not an ABI, just because
there is no framework. Userspace will be assuming it exists at the
specified location. So we cannot remove it, for existing uses of the
driver.

However, for new uses of this driver, it is O.K. to only have the
NVMEM file.

      Andrew
