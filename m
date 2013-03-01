From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Add support for deferred probing
Date: Fri, 1 Mar 2013 08:32:23 +0100
Message-ID: <20130301083223.6cf908ef@endymion.delvare>
References: <20130228120140.127ebb91@endymion.delvare>
	<51302765.8030202@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51302765.8030202-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 01 Mar 2013 11:58:29 +0800, Bo Shen wrote:
> Hi Jean,
> 
> On 2/28/2013 19:01, Jean Delvare wrote:
> > GPIOs may not be available immediately when i2c-gpio looks for them.
> > Implement support for deferred probing so that probing can be
> > attempted again later when GPIO pins are finally available.
> >
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > A little more changes were needed than I initially thought, because we
> > want to check the pins before we allocate memory. Otherwise we would
> > have a possibly large number of memory allocation and freeing cycles
> > until GPIO pins are finally available.
> >
> > I wrote this quite some time ago already, but I do not have any system
> > to test it. I would appreciate if one or more users of the i2c-gpio
> > driver could give it a try and confirm it works as intended, or at
> > least doesn't introduce any regression. Thanks.
> >
> >   drivers/i2c/busses/i2c-gpio.c |   75 ++++++++++++++++++++++++++++--------------
> >   1 file changed, 50 insertions(+), 25 deletions(-)
> 
> Test on at91sam9g20ek_2mmc board, booting with non-dt kernel and 
> dt-kernel base on Linux-3.8. Both are OK.
> 
> Tested-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks Bo, this is very appreciated!

-- 
Jean Delvare
