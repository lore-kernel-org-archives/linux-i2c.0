From: Michael Hennerich <michael.hennerich@analog.com>
Subject: question about concurrent regmap i2c usage
Date: Tue, 4 Apr 2017 10:28:23 +0200
Message-ID: <76471664-425b-c386-3ad8-efeabc2eaf7e@analog.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: broonie@kernel.org, ", linus.walleij"@linaro.org, wsa@the-dreams.de
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

During the discussion here: https://lkml.org/lkml/2017/4/4/76

A question came up, regarding whether it's recommended to mix regmap_i2c 
and plain i2c_smbus or direct adapter transfers.

In this specific case for the i2c MUX portion we need to avoid double 
locks, and therefore use un-locked direct adapter transfers.

The same time we also implement a small gpiochip, where we would like to 
use regmap to avoid some boilerplate code for the register cache.


What is your thought on this?


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
