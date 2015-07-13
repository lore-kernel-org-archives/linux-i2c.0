From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v1] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Mon, 13 Jul 2015 13:20:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507131320060.7522@pobox.suse.cz>
References: <1436504871-3676-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1436504871-3676-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 9 Jul 2015, Ellen Wang wrote:

> When doing an I2C_SMBUS_BYTE write (one byte write, no address),
> the data to be written is in "command" not "data->byte".

This is missing Signoff.

How serious is this bug in practice? Is this 4.2 material?

Thanks,

-- 
Jiri Kosina
SUSE Labs
