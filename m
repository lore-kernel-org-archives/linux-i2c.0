From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Sun, 11 May 2008 10:13:25 -0700
Message-ID: <200805111013.25440.david-b@pacbell.net>
References: <200805012046.07885.david-b@pacbell.net>
	<20080510225548.36297637@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080510225548.36297637-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 10 May 2008, you wrote:
> > =A0
> > =A0static int ali1563_block_start(struct i2c_adapter * a)
> > @@ -170,7 +170,7 @@ static int ali1563_block_start(struct i2
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data & HST_STS_BUSERR ? "No r=
esponse or Bus Collision " : "",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0data & HST_STS_DEVERR ? "Devi=
ce Error " : "",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0!(data & HST_STS_DONE) ? "Tra=
nsaction Never Finished " : "");
> > -=A0=A0=A0=A0=A0return -1;
> > +=A0=A0=A0=A0=A0return -EIO;
> > =A0}
> =

> And same here. That's a little more work, admittedly.

Returning ENXIO for BUSERR/no-response doesn't follow your
heuristic of trusting the logspam-eliminators ... plus, it's
not clear that's not a different failure mode on that path.

NVidia seems to not have ALI 1563 specs on line (sigh) so
for now I'll just stick to your heuristic.
 =

I did make the "timeout" fault unique there, since that
fault was clearly distinguishable.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
