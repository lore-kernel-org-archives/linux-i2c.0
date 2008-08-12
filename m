From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/03] i2c-i801: Fix minor style issues
Date: Tue, 12 Aug 2008 22:50:55 +0200
Message-ID: <48A1F7AF.4030707@gmail.com>
References: <48876301.9020903@gmail.com>
	<20080812102711.6f8b178a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080812102711.6f8b178a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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


> Looks OK, thanks for doing that.
>   
Seemed to be the easiest and best way to shut checkpatch up ;)
> I'm now waiting for an update of your patches based on 2.6.27-rc2 for a
> final review.
>   
I hope to have them finnished and sent tomorrow.
> Oh, one last note before I forget: as the interrupt-based logic is new
> and might not be as robust as the old poll-based one, 
Likely
> it might make
> sense to give the user a way to disable the interrupt-based logic and
> fall back to polling in case the new code doesn't work correctly.
> Without that possibility, I won't feel too confident to push your
> patches to Linus. Remember that the ICH chips are very popular and we
> just can't afford breaking these systems.
>   
True, i'd rather have that option as well.
> This could be implemented as a build time option enabling the new
> interrupt-based code, tagged EXPERIMENTAL and disabled by default, or a
> module parameter, or both.
>   
What option do you think will generate more use and thus more testing? A 
build time option (which is disabled by default thus won't be used by 
the generic user) or a module parameter which people might not know the 
existance of, but is easy to enable? Not sure what the best option is :).

> Thanks,
>   
Ivo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
