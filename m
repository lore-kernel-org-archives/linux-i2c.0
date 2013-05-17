From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
 transactions to be aborted
Date: Fri, 17 May 2013 10:06:48 -0700
Message-ID: <20130517170648.GD28484@animalcreek.com>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 16, 2013 at 09:30:59PM +0100, Russell King wrote:
> Do not use interruptible waits in an I2C driver; if a process uses
> signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
> cause the I2C driver to abort a transaction in progress by another
> driver, which can cause that driver to fail.  I2C drivers are not
> expected to abort transactions on signals.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

I don't have hardware to test but I have no issues with these patches so,
FWIW:

Acked-by: Mark A. Greer <mgreer@animalcreek.com>

for the entire series.
