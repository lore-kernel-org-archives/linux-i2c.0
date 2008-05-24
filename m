From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Sat, 24 May 2008 20:11:25 +0200
Message-ID: <20080524201125.1770d4a0@hyperion.delvare>
References: <20080524100623.3b059a49@hyperion.delvare>
	<9e4733910805240750g21130ae9sd01e928edff8eb64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910805240750g21130ae9sd01e928edff8eb64-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 24 May 2008 10:50:48 -0400, Jon Smirl wrote:
> On 5/24/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
> >
> >  This is part of the effort to get rid of the BKL.
> >
> >  [JD: In fact i2c-dev doesn't need more locking than is already done
> >  for the other i2c drivers, so we can simply switch to unlocked_ioctl.]
> 
> Note that the existing locking code in i2c (which may be correct
> without the BLK) hasn't really been tested since the BKL was
> serializing things before they got to the i2c code.

On the i2c-dev side, yes. But all other i2c chip drivers didn't get to
take the BKL, so the locking code in i2c (which definitely needs some
clean ups, but that's another story) has been tested by these and
i2c-dev isn't that different from them. That's why I believe no
particular locking is needed for i2c-dev. But of course if someone can
think of a reason why i2c-dev is different and needs additional care,
please speak up.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
