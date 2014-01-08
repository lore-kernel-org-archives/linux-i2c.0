From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
Date: Wed, 08 Jan 2014 14:44:24 +0100
Message-ID: <5524929.csF5lYbH6h@wuerfel>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <201401081352.57361.arnd@arndb.de> <52CD55D5.6020703@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52CD55D5.6020703@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 08 January 2014 14:42:45 Gregory CLEMENT wrote:
> You means something like the following code ?
> 
> static void __init armada_370_xp_dt_init(void)
>  {
> +       if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
> +               i2c_quirk();
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }

Yes, that looks like a good way to do it.

	Arnd
