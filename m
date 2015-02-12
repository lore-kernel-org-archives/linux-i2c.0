From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 11 Feb 2015 20:01:26 -0800
Message-ID: <20150212040126.GA1691@roeck-us.net>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
 <20150204190819.GA15467@roeck-us.net>
 <20150204233516.GA1677@katana>
 <20150205002630.GA396@roeck-us.net>
 <20150205144028.GA4865@katana>
 <20150205175326.GA26691@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150205175326.GA26691-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 05, 2015 at 09:53:26AM -0800, Guenter Roeck wrote:
> On Thu, Feb 05, 2015 at 03:40:28PM +0100, Wolfram Sang wrote:
> > > > > At the same time multi-master access is quite rare.
> > > > 
> > > > It should still work in those rare cases. A setup of an SoC, an EC
> > > > (those like to be masters, as well), and an EEPROM is not very far off.
> > 
> > To clarify: What I meant here is, at24 should also work in those rare
> > cases reliably (like the described case of SoC, EC and EEPROM). Your
> > patch sacrificies this reliability.
> > 
> But it won't, and it can't. 24c32 should simply not be used in such cases.
> Besides, at least on PCs, ACPI should reserve and thus block SMBus access
> if it is used by an EC (or IPMI or similar).
> 
> I don't think it should (or even can) be the Linux kernel's responsibility
> to ensure that the hardware does not prevent such problems.
> 
Hi Wolfram,

I wonder where we are with thisp patch; I don't recall a reply to my previous
e-mail.

Do you need some more time to think about it ? Otherwise I'll publish an
out-of-tree version of the at24 driver with the patch applied on github,
for those who might need the functionality provided by this patch.

Please let me know.

Thanks,
Guenter
