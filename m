From: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Fri, 15 May 2009 14:52:28 +0200
Message-ID: <d2b9ea600905150552u6951a92es5dd119dcc37e641d@mail.gmail.com>
References: <4A0BD1DB.4090305@doredevelopment.dk>
	 <20090514083453.GB3043@pengutronix.de>
	 <4A0BDAD6.5020005@doredevelopment.dk>
	 <OF9EE5E055.DDB954D2-ONC12575B6.003636EC-C12575B6.0036CB06@transmode.se>
	 <d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com>
	 <OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2@transmode.se>
	 <d2b9ea600905150318s69b86b5ct3816b274bf343a79@mail.gmail.com>
	 <OFCADC684E.A2599121-ONC12575B7.003B8AB5-C12575B7.003CF795@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OFCADC684E.A2599121-ONC12575B7.003B8AB5-C12575B7.003CF795-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Your new patch also does not work.

Have you tested it?

I already tried something very much what you sent here, I believe the
only difference was that I named the "last" variable "stop". I also
tried several other aproaches, and none of them worked.  I would
appreciate not to have to test all of them seperately again through
this mailing list ;-)

Anyway, your patch also is in conflict with the MPC8360ERM. The spec
specifies that a repeated start must follow an ACK, and not a "NO
ACK".

When doing a repeated start after a NO ACK, the slave does not ACK the
address (I get an RXAK).  When doing as specified, ACK'ing the last
byte read and then doing a repeated START, i2c_wait() fails due to
CSR_MCF bit missing.  I thought it would be possible to find somewhere
to do a dummy read to get around this, but failed to do so without
breaking something else.

Could we go forward with my initial patch, and then continue the work
on this repeated START approach for future releases?

/Esben
