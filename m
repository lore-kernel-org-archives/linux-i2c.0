From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/03] i2c-i801: Fix alignment issues
Date: Tue, 12 Aug 2008 22:43:56 +0200
Message-ID: <48A1F60C.7080505@gmail.com>
References: <488762E5.2030109@gmail.com>
	<20080812101753.592294a3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080812101753.592294a3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

Jean Delvare wrote:
> OK. There's no real need to make this a separate patch. In fact I think
> your first patch would be easier to read with these alignment issues
> fixed, as it makes it easier to figure out what code paths your changes
> are replacing. As a matter of fact, I applied this second patch before
> reviewing the first one.
>
>   
Hey Jean,

First of all, thanks a lot for reviewing. It's very appriciated. I've 
read and noted your comments, but will reply more detailed to the first 
patch later. Quite busy lately (new house, graduated => new job)..

I thought it was easier (and even required) to seperate the patches this 
way, but I seem to have been wrong ;p. Anyway, next time, this patch 
will be incorporated with the first patch. I'll leave the third patch in 
place, since it's completely unrelated.

Thanks,
Ivo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
