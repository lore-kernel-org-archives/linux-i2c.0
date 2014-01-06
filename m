From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Mon, 6 Jan 2014 16:37:27 +0100
Message-ID: <201401061637.28194.arnd@arndb.de>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401052017.10982.arnd@arndb.de> <20140105235155.GB4093@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140105235155.GB4093@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Monday 06 January 2014, Andrew Lunn wrote:
> This raises the question, should mainline try to support any random
> dtb blob, or only those that have ever shipped with mainline?

It should support any dtb that conforms to the binding.

> There are some older mainline DT blobs which won't have PCIe in them,
> since PCIe support was not there day 1. So returning -ENODEV, and the
> i2c controller assuming an A0 would make sense.

That seems reasonable, yes.

> But what should we do if somebody was to boot linux with a FreeBSD DT
> blob? It is a valid blob, it describes the hardware, but the FreeBSD
> nodes have different compatibility strings, don't have clocks, etc.
> Now that is at the extreme of the range, but where do we put the
> marker for compatibility in this range from current mainline blobs to
> FreeBSD blobs?

Are you saying that FreeBSD has a different set of bindings for the
same hardware? That would be rather unfortunate and we should probably
try to merge the bindings eventually and make sure that either OS can
boot with any conforming DTB, which means we would accept both compatible
strings, or that we make an incompatible change to the binding for at
least one of them before we call the binding stable and move the
repository to devicetree.org (or whereever it goes after moving out
of Linux).

On the example of missing clocks, it should work as long as all relevant
clocks are enabled by the boot loader and the clock properties are
optional the binding.

	Arnd
