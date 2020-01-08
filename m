From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 08/12] i2c: i2c-core-acpi: convert to use
 i2c_new_client_device()
Date: Wed, 8 Jan 2020 12:04:49 +0200
Message-ID: <20200108100449.GT465886@lahna.fi.intel.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
 <20200107174748.9616-9-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107174748.9616-9-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 07, 2020 at 06:47:42PM +0100, Wolfram Sang wrote:
> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
