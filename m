From: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Date: Thu, 28 May 2009 22:10:56 +0200
Message-ID: <d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk>
	<20090528171726.GE3112@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090528171726.GE3112@pengutronix.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Esben Haabendal <eha@doredevelopment.dk>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 28, 2009 at 7:17 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> > Any blockers to get this accepted?
>>
>> It would be nice to get an ack from someone who can actually test
>> the driver before getting this merged.
>
> I wanted to test it, but it does not apply due to line breaks (check
> @@-line). Also, I don't really have the time to dig into the topic, so I
> would only test it and give a tested-by-tag if it doesn't break anything
> here. I think Joakim would be a good candidate for an acked-by .

I've checked both my copy in my "Sent" folder and the copy received
from the list,
and I cannot see any "line break" breakage of the patch.

It must be your mail client that is messing with it, so I cannot really do it
much better in that way.

If necessary, I can push a branch to a public repo you can pull from.

/Esben
