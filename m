From: fuhz-GANU6spQydw@public.gmane.org
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Fri, 25 Jul 2008 11:00:58 +0200
Message-ID: <1216976458.4889964a5d9e2@imp.free.fr>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
	<1216909598.4888911eb6cea@imp.free.fr>
	<31e679430807241126l5bcea400ieafcfa082d11783a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430807241126l5bcea400ieafcfa082d11783a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

> are you writing a client driver or a bus driver ?

In fact, I just want to write a client driver for a embedded board.
But, the bus driver is not already ported, so I wrote an algorithm and
an adapter. I am currently write the client driver, but no client is
coming.


> might be. Why are you using 2.6.23 and not 2.6.26 ?

I want to use the 2.6.23 release because I have already a patched and
customized Linux directory tree, I don't want to merge it with new version =
of
kernel.


> But if you have to give the same name in the driver and in the
> i2c_board_info().

Ok, I have this now.


> got it ??

Not really. Thanks to you, I anderstand more about i2c layer.
But now, I think my problem is the bus driver.

I have this error :
"I2C adapter driver : forgot to specify physical device"

I don't anderstand where we are supposed to associate an adapter
with the client driver.


Thanks for help.


Best regards,

L=E9gion.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
