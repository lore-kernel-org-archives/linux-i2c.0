From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: Help Regarding I2C Driver...
Date: Tue, 24 Mar 2009 10:54:49 +0100
Message-ID: <20090324095449.GD13851@buzzloop.caiaq.de>
References: <A86BA2998E0E00468669D392AF0631BBB26E@impserver.implantaire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A86BA2998E0E00468669D392AF0631BBB26E-MbLMV4EUncCnnRLkZrclm3upHJ39lVTxwzqs5ZKRSiY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uma Kanta <upatro-cl0A3XQdnGcanlnWow0HJg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, Mar 24, 2009 at 11:06:51AM +0530, Uma Kanta wrote:
> > This version is ancient, you should consider updating to something 
> > more recent.
> 
> Yaa, this version is very old, but as currently I have to develop for
> this version  for our project so I have to try developing in this
> version itself.

[...]

> > Probing should be done by setting i2c_board_info from your board 
> > support code - also described in Documentation/i2c/writing-clients.
> 
> Actually in Linux 2.6.19 I feel that there is no provisions for
> i2c_board_info,  as non of the existing chip drivers such as eeprom,
> RTCs don't have any i2c_board_info structure in the file
> arch\arm\mach-at91rm9200\board-ek.c.
> Also in this version the function, "at91_add_device_i2c()" does not
> accept arguments  whereas in the advanced versions it takes two
> arguments such as object of structure i2c_board_info and its size.
> So what may be the alternative of i2c_board_info in case of Linux
> 2.6.19?
> Is it possible to work with I2C in  Linux 2.6.19???

Sorry, I don't know much about this legacy. I was just writing a driver
for an I2C connected device and thought I could point you in the right
direction, but that was all on cutting edge git trees. Maybe someone
else can help.

But in general, you should be able to base your work on drivers that are
there in the tree already and more or less copy their approach. It is
definitely possible to use I2C with your kernel version.

Daniel
