From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] i2c: xlp9xx: Get clock frequency with clk API
Date: Thu, 28 Sep 2017 11:49:06 +0300
Message-ID: <20170928084906.GL4630@lahna.fi.intel.com>
References: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
 <1506523943-8632-3-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506523943-8632-3-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kamlakant Patel <kamlakant.patel@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Jayachandran C <jnair@caviumnetworks.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 27, 2017 at 08:22:22PM +0530, Kamlakant Patel wrote:
> From: Jayachandran C <jnair@caviumnetworks.com>
> 
> Get the input clock frequency to the controller from the linux clk
> API, if it is available. This allows us to pass in the block input
> frequency either from ACPI (using APD) or from device tree.
> 
> The old hardcoded frequency is used as default for backwards compatibility.
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
