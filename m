From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][RESEND] i2c-i801: Add basic interrupt support
Date: Sat, 16 Aug 2008 18:22:36 +0200
Message-ID: <48A6FECC.8020801@gmail.com>
References: <48A33E77.7060502@gmail.com>
	<20080816155856.2e0bcf4c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080816155856.2e0bcf4c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hey Jean,

> I've finally renamed this to I801_INTR_EN for consistency.
>
>   
Ok
> There's some redundancy between I801_HST_STS_MASK_NORM and
> STATUS_FLAGS... It would be great to clean this up a bit, otherwise it
> will become confusing. My impression is that your
> I801_HST_STS_MASK_NORM and my STATUS_FLAGS are essentially the same. It
> should be OK to handle SMBHSTSTS_BYTE_DONE in the interrupt handler.
> That bit is set between the bytes of block transactions when the block
> buffer isn't used. Your code doesn't enable interrupts for these
> transactions at the moment, so you will never see that bit for now, but
> it might happen later as we add support.
>
> So I think I would change the code as follows:
>
> /* Mask for events we normally handle */
> #define STATUS_FLAGS		(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_FAILED | \
> 				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
> 				 SMBHSTSTS_INTR)
>
> /* Mask for all events */
> #define STATUS_FLAGS_ALL	(STATUS_FLAGS | SMBHSTSTS_SMBALERT_STS)
>
> If that's OK with you, I'll do that change myself.
>
>   
Sure, less code and better readability for basically the same 
functionality. Thanks.
> You obviously meant "use_irq", not "force".
>
>   
Ugh, yes. Glad you're paying more attention than I seem to ;p
> All the rest looks fine to me now. I'll do some more testing now.
>
>   
Great and thanks. Am really curious about the stability of this code :)
> Thanks,
>   
Ivo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
