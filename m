From: fuhz-GANU6spQydw@public.gmane.org
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Mon, 28 Jul 2008 11:36:26 +0200
Message-ID: <1217237786.488d931ac5b9b@imp.free.fr>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
	<1216909598.4888911eb6cea@imp.free.fr>
	<31e679430807241126l5bcea400ieafcfa082d11783a@mail.gmail.com>
	<1216976458.4889964a5d9e2@imp.free.fr>
	<1216994898.4889de52becd3@imp.free.fr>
	<31e679430807250726n3e4b189ehcff5dd02f46872f3@mail.gmail.com>
	<1216996221.4889e37d41fa3@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1216996221.4889e37d41fa3-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
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

In order to improve my understanding of Linux i2c layer, I read the source =
code.
I read i2c-core.c and I try to anderstand why my clients wasn't created.

The problem is in the i2c_register_adapter function :

/* create pre-declarated device nodes for new-style drivers */
if (adap->nr < __i2c_first_dynamic_bus_num)
  i2c_scan_static_board_info(adap);

The test is NEVER true. So my clients are not created.



I read that __i2c_first_dynamic_bus_num is set to 1.
It does not seems to change.

And that adap->nr refers to "Dynamic Bus Number".
My first bus register with adap->nr=3D1.
The second register with adap->nr=3D2.

That's why the test fails.


So, I have had an idea to fix the problem.

I change :
i2c_add_adapter(adap);

with
adap->nr =3D 0;
i2c_add_numbered_adapter(adap);


But, it make new problems :
- I can't manage two busses
- I definitly don't anderstand how I2C_BOARD_INFO macro can associate
  a client to a specified bus
- I don't anderstand what I am writing, and I really dislike it :c


So many questions :)

Thanks for help.


Best regards,

L=E9gion.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
