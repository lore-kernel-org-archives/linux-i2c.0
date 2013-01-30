From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Wed, 30 Jan 2013 22:55:57 +0100
Message-ID: <20130130225557.55b8eeee@endymion.delvare>
References: <20121218150337.5b861ae3@endymion.delvare>
	<1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
	<20130129150551.498b2a9b@endymion.delvare>
	<20130129153253.GA14044@hmsreliant.think-freely.org>
	<20130129231028.41b04fc9@endymion.delvare>
	<20130130141504.GA2968@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130130141504.GA2968-0o1r3XBGOEbbgkc5XkKeNuvMHUBZFtU3YPYVAmT7z5s@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 30 Jan 2013 09:15:04 -0500, Neil Horman wrote:
> On Tue, Jan 29, 2013 at 11:10:28PM +0100, Jean Delvare wrote:
> > This won't fix it, unless the hardware happens to update dma_size when
> > receiving a block from a slave. If not then dma_size will always be
> > I2C_SMBUS_BLOCK_MAX, while what we need is the number of bytes actually
> > received.
>
> I'm sorry, I misspoke.  Its the rxbytes field in the descriptor that we need to use.  I
> believe that field gets updated by the firmware on dmas from the device to the
> cpu.

I couldn't find a description of the hardware descriptor in the
datasheets, so I'm afraid I can't help here. If it is really there then
I'd be grateful if you can point me to the right file and page.

> (...)
> I'll have some tomorrow.  I've got all your trivial changes fixed up, and will
> hopefully be able to sort out the convoluted stuff with you and Seth in the next
> few days

Great. I'll be happy to test whatever you have then.

-- 
Jean Delvare
