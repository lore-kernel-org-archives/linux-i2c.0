From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.26-rc1] i2c_core:  return -Errno not -1
Date: Wed, 7 May 2008 09:52:09 +0200
Message-ID: <20080507095209.32a6faa2@hyperion.delvare>
References: <18465.22635.646092.18578@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <18465.22635.646092.18578-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Lothar =?ISO-8859-1?B?V2HfbWFubg==?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lothar,

On Wed, 7 May 2008 09:21:15 +0200, Lothar Wa=DFmann wrote:
> Fix return values of various functions in i2c-core.c to either promote
> the return code of a called function or return a sensible 'errno'
> value instead of a bogus '-1' (which would be interpreted as 'EPERM').
> =

> Signed-off-by: Lothar Wa=DFmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>

Hmm, how does your patch differ from the one David Brownell sent a few
days ago?

http://lists.lm-sensors.org/pipermail/i2c/2008-May/003503.html

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
