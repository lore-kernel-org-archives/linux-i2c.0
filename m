From: fuhz-GANU6spQydw@public.gmane.org
Subject: New Style I2C Driver : how to get clients ?
Date: Thu, 24 Jul 2008 11:07:12 +0200
Message-ID: <1216890432.48884640c4486@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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

I am currently writing a I2C driver for a custom embedded board.
I have read lot about writing I2C driver using Linux I2C layer.

But there are still a few things I don't anderstand.
I am quite confuse.



I have written an algorithm and an adapter. For instance, I just register my
adapter on the module_init.

- Is it important for adapters to be registred as platform_driver ?
- Will it remove the 'forgot to specify physical address' error ?
- Can I ignore 'forgot to specify physical address' error ?


For my driver, I only implement probe(client) and remove(client).

They are never called !!


I thought the I2C layer register automatically the I2C devices present on t=
he
bus.
Am I wrong ?

- How can I specify the addresses of my I2C clients ?
- What about i2c_probe ? Do I need to call it directly ?


Thank you for help.


Best regards.

L=E9gion.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
