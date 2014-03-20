From: Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH v5 2/2] i2c: New bus driver for the Qualcomm QUP I2C controller
Date: Thu, 20 Mar 2014 16:28:52 -0400
Message-ID: <532B4F84.7030801@codeaurora.org>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com> <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-doc-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, Andy Gross <agross@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

On 03/13/2014 10:07 PM, Bjorn Andersson wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---

[...]

Worked with an EEPROM.

Tested-by: Philip Elcan <pelcan@codeaurora.org>


-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
