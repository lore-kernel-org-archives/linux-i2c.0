From: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Thu, 28 May 2009 22:41:38 +0200
Message-ID: <d2b9ea600905281341s24efa4e3l6277a8aa5dec5bd@mail.gmail.com>
References: <4A124202.4010201@doredevelopment.dk>
	 <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	 <20090526213351.GG23114@fluff.org.uk>
	 <20090528171726.GE3112@pengutronix.de>
	 <d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>
	 <87ws8155md.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87ws8155md.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>, Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> =A0Esben> I've checked both my copy in my "Sent" folder and the copy
> =A0Esben> received from the list, and I cannot see any "line break"
> =A0Esben> breakage of the patch.
>
> I guess Wolfram referred to the context line which was clearly word w=
rapped:
>
> @@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap,
> struct i2c_msg *msgs, int num)
>
> The other lines look fine.

It's strange, that line looks perfectly fine when I check the mail in m=
y GMail
inbox and the outbox from the account I sent it from.

/Esben
--=20
Esben Haabendal, Senior Software Consultant
Dor=E9Development ApS, Ved Stranden 1, 9560 Hadsund, DK-Denmark
Phone: +45 51 92 53 93, E-mail: eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org
WWW: http://www.doredevelopment.dk
