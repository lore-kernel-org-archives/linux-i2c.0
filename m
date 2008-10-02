From: "Marco Aurelio da Costa" <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCA9665 support added to i2c-algo-pca and i2c-pca-isa.c
Date: Thu, 2 Oct 2008 20:27:05 -0300
Message-ID: <c76dcaf00810021627y561e8dbdv5e85b1bc503d1f0b@mail.gmail.com>
References: <48D3B5B7.1060402@gamic.com> <20080919145500.GH4307@pengutronix.de>
	<48D3C74E.1050801@gamic.com> <20080920072131.GB12497@pengutronix.de>
	<c76dcaf00809200409r7e0420c9rcb83a654d40e217a@mail.gmail.com>
	<c76dcaf00809200510k7e6b4648v630dc33bf6401cca@mail.gmail.com>
	<20081001173909.GG17953@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081001173909.GG17953-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram.

On Wed, Oct 1, 2008 at 2:39 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> Hi Marco,
>
> finally I came around to setup my board with the PCA9564. Here are my
> results: The algo detected the PCA9564 and moaned about the old style of
> supplying the frequency. I could easily change it to newstyle. In every
> case, I could still correctly read out the eeprom. So, everything worked
> flawlessly with a PCA9564. So, if the PCA9665 works for you and you just
> apply these minor suggestions below, I think the patch is ready for
> submission. For that, you should follow the canocical patch format
> (Documentation/SubmittingPatches, Chapter 15) when you post that
> version.

Glad to hear! I will make the changes as you sugests and submit the
patch as soon as possible. I am out of office for some time.
>
> All the best and thanks for the patch!
>

The comunity helps me so much, It is just fair that I give something back.

Best regards,

Marco

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
