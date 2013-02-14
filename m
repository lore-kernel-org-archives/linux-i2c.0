From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v3] i2c-i801: Add Device IDs for Intel Wellsburg PCH
Date: Thu, 14 Feb 2013 20:30:13 +0100
Message-ID: <20130214203013.07f59195@endymion.delvare>
References: <1360869333-2131-1-git-send-email-james.d.ralston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1360869333-2131-1-git-send-email-james.d.ralston@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: James Ralston <james.d.ralston@intel.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, Seth Heasley <seth.heasley@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 14 Feb 2013 11:15:33 -0800, James Ralston wrote:
> This patch adds the SMBus Device IDs for the Intel Wellsburg PCH
> 
> Signed-off-by: James Ralston <james.d.ralston@intel.com>
> ---
> Change notes for v3:
> *The additional Device IDs added in v2 are for the SMBus MS Unit and are referred to as SMBus_MS*. These devices are similar to the Patsburg IDF in functionality, however they are referred to as MS Unit devices in the External Design Specification.
> 
>  Documentation/i2c/busses/i2c-i801 |    1 +
>  drivers/i2c/busses/Kconfig        |    1 +
>  drivers/i2c/busses/i2c-i801.c     |   15 +++++++++++++++
>  3 files changed, 17 insertions(+), 0 deletions(-)
> (...)

Perfect, thanks James.

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
