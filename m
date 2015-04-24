From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v1 i2c/for-next] i2c-i801: recover from hardware PEC
 errors
Date: Fri, 24 Apr 2015 12:08:52 +0200
Message-ID: <20150424120852.717966f9@endymion.delvare>
References: <1428970319-32544-1-git-send-email-ellen@cumulusnetworks.com>
	<20150415140834.44b1add8@endymion.delvare>
	<552ECE19.4090705@cumulusnetworks.com>
	<20150417091751.1ae986f2@endymion.delvare>
	<5535833F.7090809@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5535833F.7090809-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ellen,

On Mon, 20 Apr 2015 15:52:47 -0700, Ellen Wang wrote:
> This leads to a related question:  If the driver is serialized, then the 
> (status = priv->status) inside wait_event_timeout() isn't strictly 
> necessary, correct?  It can just be priv->status.  I'm just want to 
> double check that there's no race and I can add a priv->auxsts and not 
> have to stick something like this inside the wait_event_timeout():
> 
>     (auxsts = priv->auxsts, status = priv->status)

To be honest I'm not 100% certain. I think this was only a minor
optimization, but I may be wrong. Adding Daniel to Cc, he added that
code to the i2c-i801 driver. Daniel, any comment on this?

Equally mysterious to me is:

		priv->status |= status;

in i801_isr() where it would seem that a simple "=" would suffice.

-- 
Jean Delvare
SUSE L3 Support
