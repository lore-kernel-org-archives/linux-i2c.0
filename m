From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Thu, 17 Nov 2011 11:23:48 -0800
Message-ID: <1321557828.16541.62.camel@oslab-l1>
References: <1321338462-6138-1-git-send-email-guenter.roeck@ericsson.com>
	 <CAOZdJXUPO5PyMkAw-2EPvy_qSUuqsgUA7Gr8mKUX7HyShoXk3g@mail.gmail.com>
	 <E6AF40B3BFC8A9428EACB47497F0F4B62DC687@039-SN1MPN1-002.039d.mgd.msft.net>
	 <ECEE0D23-8F53-402C-A97F-4DB0F0E9C79B@freescale.com>
	 <1321464509.7847.41.camel@oslab-l1>
	 <1321464968.2309.384.camel@groeck-laptop>
	 <1321466135.7847.55.camel@oslab-l1>
	 <20111116190954.67c846fc@endymion.delvare>
	 <1321467638.7847.73.camel@oslab-l1>
	 <20111116201048.4b7877dd@endymion.delvare>
	 <1321470915.7847.122.camel@oslab-l1>
	 <20111116201847.6b11dc7f@endymion.delvare>
	 <1321471473.7847.126.camel@oslab-l1>
	 <1321553924.2730.7.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321553924.2730.7.camel@groeck-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > That's the point. Your patch doesn't check if the length is valid. You
> > rely on the caller to know no more than 32 bytes can be transferred. It
> > shouldn't limit the subfunction to transfer more than 32 bytes if
> > hardware can support it by multiple transactions. If not, print out an
> > error message.
> > 
> 
> It is customary for kernel functions to only validate parameters
> wherever a value enters or leaves the kernel, or at least a logical
> boundary. Anything else would blow up the kernel size to a point where
> it would be unusable. The patch checks if the block length received from
> the SMBus slave is correct, which is exactly what it is supposed to do.
> 
> If you look closely, you may realize that the mpc_read also doesn't
> validate of any of the other parameters. Are you going to request that
> such validations be added as well ? How about the other functions in
> this driver ? Should each function also validate each of its
> parameters ? If not, where do you draw the line ?
> 
> Besides, the caller is the SMBus block read function, which does know
> that SMBus block reads are limited to 32 bytes (plus length).
> 

I am going to let it go for now. Obviously your patch is working when
length=1. Probably it will never be called with length other than 1 for
SMBus block read. It would be nicer if you could put a comment there
just in case in the future someone runs into a case where length+=byte
causes a problem.

York
