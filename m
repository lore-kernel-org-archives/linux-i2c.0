From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH RESEND 1/1] i2c: Add support for Xilinx XPS IIC Bus
 Interface
Date: Sun, 24 Jan 2010 19:54:46 +0100
Message-ID: <20100124195446.2268fd20@hyperion.delvare>
References: <4B55D74C.2010806@pelagicore.com>
	<20100124154930.GE28675@fluff.org.uk>
	<4B5C8460.2040309@pelagicore.com>
	<20100124181526.GB25641@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100124181526.GB25641-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Richard =?UTF-8?B?UsO2amZvcnM=?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 24 Jan 2010 19:15:26 +0100, Wolfram Sang wrote:
> > >> + * i2c-xiic.c
> > > 
> > > the directory path to the file would have been nice.
> > 
> > Will update
> 
> Ben, are you sure? Those filenames (especially with directories) easily go
> stale when reorganizing the tree.

FWIW, I agree with Wolfram on that. Embedding the path in the header
comment of a file doesn't add any value.

-- 
Jean Delvare
