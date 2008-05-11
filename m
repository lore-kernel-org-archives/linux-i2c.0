From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-git] i2c_adapters:  return -Errno not -1
Date: Sun, 11 May 2008 10:16:59 -0700
Message-ID: <200805111016.59365.david-b@pacbell.net>
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

On Saturday 10 May 2008, Jean Delvare wrote:
> > =A0=A0=A0=A0=A0=A0amd_ec_write(smbus, AMD_SMB_ADDR, addr << 1);
> > =A0=A0=A0=A0=A0=A0amd_ec_write(smbus, AMD_SMB_PRTCL, protocol);
> > =A0
> > +=A0=A0=A0=A0=A0/* FIXME this discards status from ec_read() ... */
> > =A0=A0=A0=A0=A0=A0amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
> =

> Same is true of almost all amd_ec_write and amd_ec_read calls, so I
> don't get the point of adding a comment for this one occurrence in
> particular.
> =

> > =A0
> > =A0=A0=A0=A0=A0=A0if (~temp[0] & AMD_SMB_STS_DONE) {

I updated that comment.  The issue is that temp[0] will
have random stack garbage at that point, so the rest of
that routine is at best dicey.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
