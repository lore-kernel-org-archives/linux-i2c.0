From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 11/17] i2c: nomadik: Convert to devm functions
Date: Tue, 18 Feb 2014 12:43:22 +0100
Message-ID: <CAPDyKFpRaAAer00dqcXR-qOT9S8-SDTnaMUHRwWCZ93w-wnTDA@mail.gmail.com>
References: <1392650418-14820-1-git-send-email-ulf.hansson@linaro.org>
 <20140218110109.GA18768@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140218110109.GA18768@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-i2c@vger.kernel.org

On 18 February 2014 12:01, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Feb 17, 2014 at 04:20:18PM +0100, Ulf Hansson wrote:
>> Use devm_* functions to simplify code and error handling.
>>
>> Cc: Alessandro Rubini <rubini@unipv.it>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> What has changed in V3? I didn't get the cover letter.

I added the IS_ERR, check as you suggested. That caused a rebase of
the other patches as well.

Sorry if it was unclear.

Kind regards
Uffe
