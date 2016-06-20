From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/2] i2c: qup: add ACPI support
Date: Mon, 20 Jun 2016 18:07:22 +0300
Message-ID: <20160620150722.GP1739@lahna.fi.intel.com>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
 <20160618141034.GB1430@tetsubishi>
 <20160620082420.GX1739@lahna.fi.intel.com>
 <5768051E.3020008@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5768051E.3020008@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Austin Christ <austinwc@codeaurora.org>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, rruigrok@codeaurora.org, nkaje@codeaurora.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cov@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 20, 2016 at 10:00:46AM -0500, Timur Tabi wrote:
> Mika Westerberg wrote:
> > Use has_acpi_companion() if you need to.
> 
> Is has_acpi_companion() the preferred alternative to ACPI_HANDLE()?  We
> frequently need to write code that does something different on ACPI vs DT,
> and there doesn't appear to be much consistency on how that's handled.

Yes, that's the preferred one.
