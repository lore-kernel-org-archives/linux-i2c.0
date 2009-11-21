From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
Date: Sat, 21 Nov 2009 18:27:54 +0100
Message-ID: <63386a3d0911210927u47c7d6d6i65fc7d60563f8db2@mail.gmail.com>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Wells <kevin.wells@nxp.com>, Vitaly Wool <vitalywool@gmail.com>
List-Id: linux-i2c@vger.kernel.org

If you have this up for testing anyway, would it be advisable to take this
opportunity to also switch i2c-pnx over to using struct dev_pm_ops?

i2c-pxa, i2c-s3c2410 and i2c-sh_mobile are already using the new
PM primitives.

Yours,
Linus Walleij
