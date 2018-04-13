From: Sam Hansen <hansens@google.com>
Subject: Re: [PATCH v2 3/3] Documentation/i2c: adopt kernel commenting style
 in examples
Date: Fri, 13 Apr 2018 10:39:19 -0700
Message-ID: <CAP9bUy6_sGreanxger04mtyHAVSb0tyFe8Ji0+ocUUxTh9C+3Q@mail.gmail.com>
References: <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
 <20180413164405.127522-1-hansens@google.com> <20180413164405.127522-3-hansens@google.com>
 <20180413165000.2svg2j5ozdd2egbd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413165000.2svg2j5ozdd2egbd@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 13, 2018 at 9:50 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> -  int adapter_nr = 2; /* probably dynamically determined */
>
> Such comments are actually OK.

Ah, gotcha.  Thanks for the correction.  Standby for revised patch set.

>
>> -    /* ERROR HANDLING; you can check errno to see what went wrong */
>
> Such as well.
>
>> -  /* Using I2C Write, equivalent of
>> -     i2c_smbus_write_word_data(file, reg, 0x6543) */
>> +  /*
>> +   * Using I2C Write, equivalent of
>> +   * i2c_smbus_write_word_data(file, reg, 0x6543).
>> +   */
>
> This is the only broken one AFAICT.
>
