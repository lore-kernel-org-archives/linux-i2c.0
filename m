From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
Date: Wed, 08 Jan 2014 14:45:26 +0100
Message-ID: <3195222.U7OZJLz9Y4@wuerfel>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <52CD4CBE.6010902@free-electrons.com> <20140108133958.GA15182@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140108133958.GA15182@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, stable@vger.kernel.org, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 08 January 2014 14:39:59 Wolfram Sang wrote:
> > >>>> However, when I first read this I thought it should be a -a0 specific
> > >>>> compatible string, not a 'offload-broken' property - any idea what the
> > >>>> DT consensus is here? I've seen both approach in use ..
> > >>>
> > >>> I prefer the replacement of the compatible string. If it should really
> > >>> be a seperate property, then it should be a vendor specific property. It
> > >>> is not generic, at all.
> > >>
> > >> Something like "marvell,offload-broken" would be acceptable?
> > > 
> > > A tad more, yes. Still, since this is a feature/quirk of the IP core
> > > revision, it should be deduced from the compatible property IMO. It
> > > cannot be configured anywhere, so it doesn't change on board level.
> > 
> > So you would prefer using the "marvell,mv78230-a0-i2c" comaptible string and
> > updating it with the follwing piece of code?
> 
> This is the approach I favour, yes. Can't say much about the
> implementation. Looks OK, but dunno if this is minimal...
> 

I would prefer the separate property in this case, but only because it's
easier to add in the quirk than to change the compatible string, but it's
not a strong preference and I don't mind getting overruled if you all
favor the alternative.

	Arnd
