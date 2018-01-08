From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a
 module
Date: Mon, 8 Jan 2018 11:22:11 -0500
Message-ID: <763cc5e7-e22b-ed23-c262-b3fc1103d6f0@codeaurora.org>
References: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 1/3/2018 9:02 AM, Eric Auger wrote:
> If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
> and any ACPI opregion calls targeting I2C fail with no opregion found.
> 
> This patch allows ACPI_I2C_OPREGION to be enabled both if I2C is
> built into the kernel or built as a module.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Hoping this makes to 4.16.

Tested-by: Sinan Kaya <okaya@codeaurora.org>

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
