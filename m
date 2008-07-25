From: fuhz-GANU6spQydw@public.gmane.org
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Fri, 25 Jul 2008 16:08:18 +0200
Message-ID: <1216994898.4889de52becd3@imp.free.fr>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
	<1216909598.4888911eb6cea@imp.free.fr>
	<31e679430807241126l5bcea400ieafcfa082d11783a@mail.gmail.com>
	<1216976458.4889964a5d9e2@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1216976458.4889964a5d9e2-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
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

Hello,

Ok, I have just read my code carefully and correct some mistakes.
It is quite clean now, but I still don't get my clients.

In the board initialisation file, I define two things :
- a platform_device for my I2C bus
  The name field correspond to the adapter platform_driver.name
- a valid i2c_board_info struct defining my clients
  The name field correspond to the client i2c_driver.name
  I do not care about type field, I just use the I2C_BOARD_INFO macro

I have written different modules for the algorithm, the adapter, and the cl=
ient.

First at all, I load the client driver with insmod utility.
Then, I load the algorithm.
And finally, I load the adapter.

When the adapter is loaded, my probe(platform_device) is correctly called.
I allocate a new structure correctly and register a new adapter.

On the remove callback function, I deallocate it.


No client is registred to my i2c_driver, so where is the mistake ?



> got it ??

As soon as possible :-)



Best regards,

L=E9gion.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
