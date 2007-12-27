From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Thu, 27 Dec 2007 15:59:31 -0800
Message-ID: <200712271559.31579.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<57e2b00712271409n6c98f76o45116cd92b01f396@mail.gmail.com>
	<200712271506.43069.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200712271506.43069.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
To: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 27 December 2007, David Brownell wrote:
> > Is there something else that I'm missing?
> =

> I'm not sure yet. =A0I certainly tested that updated at24 driver
> with lockdep active, and it didn't report such a warning. =A0It's
> possible lockdep on that platform isn't fully functional yet;
> I'll see if that problem triggers on a different arch (after
> some intentional misconfiguration to call this utility).

Just tried it on ARM, and it worked just fine.  Lockdep reported
no warnings, and that hacked 24c512 EEPROM claims three extra
addresses using i2c_new_dummy().

- Dave


> One thing that looks odd in your stack trace is that it shows
> i2c_attach_client() calling mutex_lock_nested(), which is most
> certainly not what it does in rc6-git-current ... in fact, a
> nested call is made (rather curiously) only in i2c_transfer().
> =

> Do you have other I2C patches that may be causing problems?
