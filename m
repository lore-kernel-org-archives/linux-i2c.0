From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags
Date: Thu, 28 Sep 2017 11:50:21 +0300
Message-ID: <20170928085021.GM4630@lahna.fi.intel.com>
References: <1506523943-8632-1-git-send-email-kamlakant.patel@cavium.com>
 <1506523943-8632-4-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506523943-8632-4-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kamlakant Patel <kamlakant.patel@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jayachandran C <jnair@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 27, 2017 at 08:22:23PM +0530, Kamlakant Patel wrote:
> +	priv->len_recv = (msg->flags & I2C_M_RECV_LEN);

You don't need parens here.

> +	len = priv->len_recv ? XLP9XX_I2C_FIFO_SIZE : msg->len;
> +	priv->client_pec = (msg->flags & I2C_CLIENT_PEC);

Ditto.

Otherwise looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
