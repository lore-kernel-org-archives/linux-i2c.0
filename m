From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c: Use i2c_listener in driver f75375s
Date: Thu, 5 Jun 2008 11:06:59 +0200
Message-ID: <20080605110659.3456fbe4@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604203322.472f8653@hyperion.delvare>
	<4847A4E2.9040406@movial.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4847A4E2.9040406-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Riku Voipio <riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Jun 2008 11:33:38 +0300, Riku Voipio wrote:
> Jean Delvare wrote:
> > Replace the legacy f75375s i2c_driver by an i2c_listener.
> >
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> > Riku, any chance you could test this one? Thanks.
> >   
> I can test that the new style driver still works after these tests,
> but I don't have testing if the driver still works  in
> cases were f75375_legacy driver used to work (which I guess is what
> you are interested in) is tricker. I do however like the concept.

I have already tested the latter, using i2c-stub + a dump of a F75375S
chip. So if you can test the former (new-style) we cover the whole set
of possibilities and that's alright :)

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
