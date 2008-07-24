From: fuhz-GANU6spQydw@public.gmane.org
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Thu, 24 Jul 2008 14:52:29 +0200
Message-ID: <1216903949.48887b0dd2039@imp.free.fr>
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

Hi,

Thank you for your fast answer.


So, I added the register_board_info in my board init function.
I fill the i2c_board_info structure with the macro I2C_BOARD_INFO.
I define a few clients.

And so what ?

The system is supposed to call the probe(client) of the driver ?


I am really lost. I did not anderstand how to get a valid client instance.
I suppose the I2C layer says "Hey boy, you have a new client !", but when ?


What about 'static unsigned short probe[2] =3D { I2C_CLIENT_END, I2C_CLIENT=
_END
};'.
Can it help me ?


Thank you in advance.


Best regards,

L=E9gion.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
