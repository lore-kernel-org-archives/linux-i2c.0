From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by  read i2c_msg
Date: Thu, 28 May 2009 22:34:18 +0200
Message-ID: <87ws8155md.fsf@macbook.be.48ers.dk>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk>
	<20090528171726.GE3112@pengutronix.de>
	<d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d2b9ea600905281310p16f47ed0i454e25bf256d3010-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> (Esben Haabendal's message of "Thu\, 28 May 2009 22\:10\:56 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>, Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Esben" == Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

Hi,

 >> I wanted to test it, but it does not apply due to line breaks (check
 >> @@-line). Also, I don't really have the time to dig into the topic, so I
 >> would only test it and give a tested-by-tag if it doesn't break anything
 >> here. I think Joakim would be a good candidate for an acked-by .

 Esben> I've checked both my copy in my "Sent" folder and the copy
 Esben> received from the list, and I cannot see any "line break"
 Esben> breakage of the patch.

I guess Wolfram referred to the context line which was clearly word wrapped:

@@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap,
struct i2c_msg *msgs, int num)

The other lines look fine.

-- 
Bye, Peter Korsgaard
