From: Andrew Worsley <amworsley@gmail.com>
Subject: Re: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
Date: Wed, 18 Oct 2017 20:41:26 +1100
Message-ID: <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
References: <20170916030252.10680-1-amworsley@gmail.com> <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato> <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
 <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com> <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a11428a542dfe98055bcf0b77"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:52026 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933078AbdJRJl2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 05:41:28 -0400
Received: by mail-ua0-f169.google.com with SMTP id 47so3098483uas.8
        for <linux-i2c@vger.kernel.org>; Wed, 18 Oct 2017 02:41:28 -0700 (PDT)
In-Reply-To: <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Harini Katakam <harinikatakamlinux@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Harini Katakam <harinik@xilinx.com>

--001a11428a542dfe98055bcf0b77
Content-Type: text/plain; charset="UTF-8"

On 16 October 2017 at 21:38, Harini Katakam
<harinikatakamlinux@gmail.com> wrote:
> Hi Andrew,

Hi Harini, I did manage to reproduce the issue and got some more info
on  the bug some more
- but I don't  really understanding the cause.

> On Mon, Oct 16, 2017 at 2:48 PM, Andrew Worsley <amworsley@gmail.com> wrote:
>> Thanks I think I know understand how this transfer register is set up.
>> I will add some diagnostic printk's to track down exactly how it is
>> failing and get back to you.


It appears to be working fine and then just fails with  the transfer
size register value set to 242.
Always the value 240 or  242 in the transfer register.

>>
>>  Yes it is zynq. The test case is large (128 byte) transfers from a
>> tpm to fill an rng driver. I just pull large amounts of data via dd.
>>

I have a lot of data so I will summarise it and I can post more
details on what people want to know.

I added printk's on each i2c operation and each write to the transfer
size register.
When the overrun is hit it prints out most of the registers, about
half the time the overflow bit is set.

Here is my last output which has the most diagnostics:
...
[   15.607821] zs2 kernel: cdns_i2c_process_msg: Rd len=142 #8
[   15.607826] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(142,
CDNS_I2C_XFER_SIZE_OFFSET)
 #6
[   15.611343] zs2 kernel: cdns_i2c_process_msg: Wr len=14 #8
[   15.611777] zs2 kernel: cdns_i2c_process_msg: Rd len=35 #8
[   15.611781] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(35,
CDNS_I2C_XFER_SIZE_OFFSET)
#6
[   15.611836] zs2 kernel: cdns_i2c_master_reset:cdns_i2c_writereg(0,
CDNS_I2C_XFER_SIZE_OF
FSET) #4
[   15.612847] zs2 kernel: cdns_i2c_process_msg: Rd len=35 #8
[   15.612850] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(35,
CDNS_I2C_XFER_SIZE_OFFSET)
#6
[   15.612911] zs2 kernel: cdns_i2c_master_reset:cdns_i2c_writereg(0,
CDNS_I2C_XFER_SIZE_OF
FSET) #4
[   15.613924] zs2 kernel: cdns_i2c_process_msg: Rd len=35 #8
[   15.613928] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(35,
CDNS_I2C_XFER_SIZE_OFFSET)
#6
[   15.614836] zs2 kernel: tpm_transmit: after req_complete_val status=0x1
[   15.614846] zs2 kernel: cdns_i2c_process_msg: Rd len=142 #8
[   15.614851] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(142,
CDNS_I2C_XFER_SIZE_OFFSET)
 #6
[   15.626087] zs2 kernel: cdns_i2c_isr: buffer overrunning !!!-
transfer-size=242 ctrl=0xc0f status=0x120 int-status=0x0
[   15.626091] zs2 kernel: cdns_i2c_isr:Aborting transfer...
....

I tried to handle situation by setting the transfer register to zero
and breaking out of the loop which is copying bytes out of the FIFO.
At no time are any of the transfers bigger than 142 bytes or so as
shown above. So the driver  always sets the transfer register to the
full size.

The only writes to the transfer register are 0,  1, 35 and 142. I
never see an overly large write to the transfer register.

>>> Could you please provide more details of your application and
>>> setup?
>>>
>>> Regards,
>>> Harini
>>

I originally discovered the flaw with two of the last i2c-cadence
driver fixes not present

  Initialize-configuration-before-prob
  fix-ctrl-addr-reg-write-order

 and a fair amount of debug in the TPM driver - then the bug hit
nearly every run.
With these two i2c fixes in it occured only once per 4-5 runs.

Perhaps this information gives some one a path to investigate further?
I can't really see how this transfer size register can get confused -
especially always with 240 or 242 = 255-13
Perhaps the transfer register rolls over from zero or something?
Or Perhaps I am just looking for magic numbers?


>>
>> Assuming it is not obvious how to fix it - perhaps I can try setting
>> the transfer register to zero when it hits the end of the transfer?
>> (if recv_count == 0).
>
> Yes, that can be done as a workaround but ideally, the transfer
> size register should have decremented to zero by this point.

Setting the transfer size to zero and then doing a break on an error
is ok but causes the transfer to fail still.
Now thinking about it perhaps I should have done a continue - so the
loop would terminate more naturally.

>>
>> Thanks very much Harini  - that was just the pointer I needed to
>> follow the code.
>
> Thanks for the information - please let me know what you find.
>
> Regards,
>

Let me know if you have any other suggestions for me to try. my tpm
driver changes are not in main line so it's hard for anyone else to do
exactly that test case.
I can't get back to this till next week so I won't be able to try this
till then.
My thoughts are to remove the TPM debugging code to confirm that no
other changes are needed to reproduce this issue.
But I can't see how anything can overwrite the transfer register.

> Harini

I attach a patch of the changes to the i2c driver showing my debug in
this driver.
As I said I am happy to send more verbose bug output - I have about 36
odd runs with 9 occurences of the bug.
Once it happen twice in the one run

I include the crashing line from the runs where the bug occured (I
added more diagnostics as the runs progressed):
% grep overrunning i2c-tpm-run*
i2c-tpm-run12-bad-rev-ecbd28b9.txt:[    8.543441] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242
i2c-tpm-run13-bad-rev-ecbd28b9.txt:[   16.193018] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242
i2c-tpm-run18-bad-rev-ecbd28b9.txt:[   26.065783] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0 int-status=0x0
i2c-tpm-run18-bad-rev-ecbd28b9.txt:[   30.272113] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0 int-status=0x0
i2c-tpm-run21-bad-rev-ecbd28b9.txt:[   20.162880] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0=>Overflow<= int-status=0x0
i2c-tpm-run24-bad-rev-ecbd28b9.txt:[   15.191316] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242 ctrl=0xc0f
status=0x120 int-status=0x0
i2c-tpm-run26-bad-rev-ecbd28b9.txt:[   18.370014] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0=>Overflow<= int-status=0x0
i2c-tpm-run30-bad-rev-ecbd28b9.txt:[   20.177092] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242 ctrl=0xc0f
status=0x120 int-status=0x0
i2c-tpm-run36-bad-rev-ecbd28b9.txt:[   15.626087] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242 ctrl=0xc0f
status=0x120 int-status=0x0

I attach the diff of the changes to the i2c-cadence driver file

Suggestions appreciated.

Andrew

--001a11428a542dfe98055bcf0b77
Content-Type: text/x-patch; charset="US-ASCII"; name="i2c-cadence.patch"
Content-Disposition: attachment; filename="i2c-cadence.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j8wujh500

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtY2FkZW5jZS5jIGIvZHJpdmVycy9p
MmMvYnVzc2VzL2kyYy1jYWRlbmNlLmMKaW5kZXggNzVkODAxNjE5MzFmLi5hNjEwM2MzMDNiMDgg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtY2FkZW5jZS5jCisrKyBiL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtY2FkZW5jZS5jCkBAIC0yNDYsNiArMjQ2LDIwIEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBjZG5zX2kyY19pc3IoaW50IGlycSwgdm9pZCAqcHRyKQogCQkJICAgICFpZC0+
YnVzX2hvbGRfZmxhZykKIAkJCQljZG5zX2kyY19jbGVhcl9idXNfaG9sZChpZCk7CiAKKyAgICAg
ICAgICAgIGlmIChpZC0+cmVjdl9jb3VudCA9PSAwKQorICAgICAgICAgICAgeworICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGludCBzdCA9IGNkbnNfaTJjX3JlYWRyZWcoQ0ROU19JMkNfU1JfT0ZG
U0VUKTsKKyAgICAgICAgICAgICAgICBwcl9ub3RpY2UoIiVzOiBidWZmZXIgb3ZlcnJ1bm5pbmcg
ISEhLSB0cmFuc2Zlci1zaXplPSVkIGN0cmw9JSN4IHN0YXR1cz0lI3glcyBpbnQtc3RhdHVzPSUj
eFxuIiwKKyAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sCisgICAgICAgICAgICAgICAgICAg
IGNkbnNfaTJjX3JlYWRyZWcoQ0ROU19JMkNfWEZFUl9TSVpFX09GRlNFVCksCisgICAgICAgICAg
ICAgICAgICAgIGNkbnNfaTJjX3JlYWRyZWcoQ0ROU19JMkNfQ1JfT0ZGU0VUKSwKKyAgICAgICAg
ICAgICAgICAgICAgc3QsIHN0ICYgQklUKDcpID8gIj0+T3ZlcmZsb3c8PSIgOiAiIiwKKyAgICAg
ICAgICAgICAgICAgICAgY2Ruc19pMmNfcmVhZHJlZyhDRE5TX0kyQ19JU1JfT0ZGU0VUKQorICAg
ICAgICAgICAgICAgICAgICApOworICAgICAgICAgICAgICAgIHByX25vdGljZSgiJXM6QWJvcnRp
bmcgdHJhbnNmZXIuLi5cbiIsIF9fZnVuY19fKTsKKyAgICAgICAgICAgICAgICBjZG5zX2kyY193
cml0ZXJlZygwLCBDRE5TX0kyQ19YRkVSX1NJWkVfT0ZGU0VUKTsKKyAgICAgICAgICAgICAgICBi
cmVhazsKKyAgICAgICAgICAgIH0KIAkJCSooaWQtPnBfcmVjdl9idWYpKysgPQogCQkJCWNkbnNf
aTJjX3JlYWRyZWcoQ0ROU19JMkNfREFUQV9PRkZTRVQpOwogCQkJaWQtPnJlY3ZfY291bnQtLTsK
QEAgLTI3NCwxMSArMjg4LDE1IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBjZG5zX2kyY19pc3IoaW50
IGlycSwgdm9pZCAqcHRyKQogCQkJICovCiAJCQlpZiAoKChpbnQpKGlkLT5yZWN2X2NvdW50KSAt
IENETlNfSTJDX0ZJRk9fREVQVEgpID4KIAkJCSAgICBDRE5TX0kyQ19UUkFOU0ZFUl9TSVpFKSB7
CisgICAgICAgICAgICAgICAgcHJfaW5mbygiJXM6Y2Ruc19pMmNfd3JpdGVyZWcoJWQsIENETlNf
STJDX1hGRVJfU0laRV9PRkZTRVQpICMxXG4iLAorICAgICAgICAgICAgICAgICAgICBfX2Z1bmNf
XywgQ0ROU19JMkNfVFJBTlNGRVJfU0laRSk7CiAJCQkJY2Ruc19pMmNfd3JpdGVyZWcoQ0ROU19J
MkNfVFJBTlNGRVJfU0laRSwKIAkJCQkJCSAgQ0ROU19JMkNfWEZFUl9TSVpFX09GRlNFVCk7CiAJ
CQkJaWQtPmN1cnJfcmVjdl9jb3VudCA9IENETlNfSTJDX1RSQU5TRkVSX1NJWkUgKwogCQkJCQkJ
ICAgICAgQ0ROU19JMkNfRklGT19ERVBUSDsKIAkJCX0gZWxzZSB7CisgICAgICAgICAgICAgICAg
cHJfaW5mbygiJXM6Y2Ruc19pMmNfd3JpdGVyZWcoJWQsIENETlNfSTJDX1hGRVJfU0laRV9PRkZT
RVQpICMyXG4iLAorICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaWQtPnJlY3ZfY291bnQg
LSBDRE5TX0kyQ19GSUZPX0RFUFRIKTsKIAkJCQljZG5zX2kyY193cml0ZXJlZyhpZC0+cmVjdl9j
b3VudCAtCiAJCQkJCQkgIENETlNfSTJDX0ZJRk9fREVQVEgsCiAJCQkJCQkgIENETlNfSTJDX1hG
RVJfU0laRV9PRkZTRVQpOwpAQCAtMjkyLDEwICszMTAsMTQgQEAgc3RhdGljIGlycXJldHVybl90
IGNkbnNfaTJjX2lzcihpbnQgaXJxLCB2b2lkICpwdHIpCiAJCQkJCQlDRE5TX0kyQ19BRERSX09G
RlNFVCk7CiAKIAkJCWlmIChpZC0+cmVjdl9jb3VudCA+IENETlNfSTJDX1RSQU5TRkVSX1NJWkUp
IHsKKyAgICAgICAgICAgICAgICBwcl9pbmZvKCIlczpjZG5zX2kyY193cml0ZXJlZyglZCwgQ0RO
U19JMkNfWEZFUl9TSVpFX09GRlNFVCkgIzNcbiIsCisgICAgICAgICAgICAgICAgICAgIF9fZnVu
Y19fLCBDRE5TX0kyQ19UUkFOU0ZFUl9TSVpFKTsKIAkJCQljZG5zX2kyY193cml0ZXJlZyhDRE5T
X0kyQ19UUkFOU0ZFUl9TSVpFLAogCQkJCQkJQ0ROU19JMkNfWEZFUl9TSVpFX09GRlNFVCk7CiAJ
CQkJaWQtPmN1cnJfcmVjdl9jb3VudCA9IENETlNfSTJDX1RSQU5TRkVSX1NJWkU7CiAJCQl9IGVs
c2UgeworICAgICAgICAgICAgICAgIHByX2luZm8oIiVzOmNkbnNfaTJjX3dyaXRlcmVnKCVkLCBD
RE5TX0kyQ19YRkVSX1NJWkVfT0ZGU0VUKSAjNFxuIiwKKyAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18sIGlkLT5yZWN2X2NvdW50KTsKIAkJCQljZG5zX2kyY193cml0ZXJlZyhpZC0+cmVjdl9j
b3VudCwKIAkJCQkJCUNETlNfSTJDX1hGRVJfU0laRV9PRkZTRVQpOwogCQkJCWlkLT5jdXJyX3Jl
Y3ZfY291bnQgPSBpZC0+cmVjdl9jb3VudDsKQEAgLTM5OCwxMCArNDIwLDE0IEBAIHN0YXRpYyB2
b2lkIGNkbnNfaTJjX21yZWN2KHN0cnVjdCBjZG5zX2kyYyAqaWQpCiAJICogaXQgaXMgbW9yZS4g
RW5hYmxlIHRoZSBpbnRlcnJ1cHRzLgogCSAqLwogCWlmIChpZC0+cmVjdl9jb3VudCA+IENETlNf
STJDX1RSQU5TRkVSX1NJWkUpIHsKKyAgICAgICAgcHJfaW5mbygiJXM6Y2Ruc19pMmNfd3JpdGVy
ZWcoJWQsIENETlNfSTJDX1hGRVJfU0laRV9PRkZTRVQpICM1XG4iLAorICAgICAgICAgICAgX19m
dW5jX18sIENETlNfSTJDX1hGRVJfU0laRV9PRkZTRVQpOwogCQljZG5zX2kyY193cml0ZXJlZyhD
RE5TX0kyQ19UUkFOU0ZFUl9TSVpFLAogCQkJCSAgQ0ROU19JMkNfWEZFUl9TSVpFX09GRlNFVCk7
CiAJCWlkLT5jdXJyX3JlY3ZfY291bnQgPSBDRE5TX0kyQ19UUkFOU0ZFUl9TSVpFOwogCX0gZWxz
ZSB7CisgICAgICAgIHByX2luZm8oIiVzOmNkbnNfaTJjX3dyaXRlcmVnKCVkLCBDRE5TX0kyQ19Y
RkVSX1NJWkVfT0ZGU0VUKSAjNlxuIiwKKyAgICAgICAgICAgIF9fZnVuY19fLCBpZC0+cmVjdl9j
b3VudCk7CiAJCWNkbnNfaTJjX3dyaXRlcmVnKGlkLT5yZWN2X2NvdW50LCBDRE5TX0kyQ19YRkVS
X1NJWkVfT0ZGU0VUKTsKIAl9CiAKQEAgLTQ5OSw2ICs1MjUsOCBAQCBzdGF0aWMgdm9pZCBjZG5z
X2kyY19tYXN0ZXJfcmVzZXQoc3RydWN0IGkyY19hZGFwdGVyICphZGFwKQogCXJlZ3ZhbCB8PSBD
RE5TX0kyQ19DUl9DTFJfRklGTzsKIAljZG5zX2kyY193cml0ZXJlZyhyZWd2YWwsIENETlNfSTJD
X0NSX09GRlNFVCk7CiAJLyogVXBkYXRlIHRoZSB0cmFuc2ZlcmNvdW50IHJlZ2lzdGVyIHRvIHpl
cm8gKi8KKyAgICBwcl9pbmZvKCIlczpjZG5zX2kyY193cml0ZXJlZyglZCwgQ0ROU19JMkNfWEZF
Ul9TSVpFX09GRlNFVCkgIzRcbiIsCisgICAgICAgIF9fZnVuY19fLCAwKTsKIAljZG5zX2kyY193
cml0ZXJlZygwLCBDRE5TX0kyQ19YRkVSX1NJWkVfT0ZGU0VUKTsKIAkvKiBDbGVhciB0aGUgaW50
ZXJ1cHQgc3RhdHVzIHJlZ2lzdGVyICovCiAJcmVndmFsID0gY2Ruc19pMmNfcmVhZHJlZyhDRE5T
X0kyQ19JU1JfT0ZGU0VUKTsKQEAgLTUzMCw2ICs1NTgsNyBAQCBzdGF0aWMgaW50IGNkbnNfaTJj
X3Byb2Nlc3NfbXNnKHN0cnVjdCBjZG5zX2kyYyAqaWQsIHN0cnVjdCBpMmNfbXNnICptc2csCiAJ
CQkJCUNETlNfSTJDX0NSX09GRlNFVCk7CiAJfQogCisgICAgcHJfaW5mbygiJXM6ICVzIGxlbj0l
ZCAjOFxuIiwgX19mdW5jX18sIG1zZy0+ZmxhZ3MgJiBJMkNfTV9SRCA/ICJSZCIgOiAiV3IiLCBt
c2ctPmxlbik7CiAJLyogQ2hlY2sgZm9yIHRoZSBSL1cgZmxhZyBvbiBlYWNoIG1zZyAqLwogCWlm
IChtc2ctPmZsYWdzICYgSTJDX01fUkQpCiAJCWNkbnNfaTJjX21yZWN2KGlkKTsKQEAgLTYyOSw2
ICs2NTgsNyBAQCBzdGF0aWMgaW50IGNkbnNfaTJjX21hc3Rlcl94ZmVyKHN0cnVjdCBpMmNfYWRh
cHRlciAqYWRhcCwgc3RydWN0IGkyY19tc2cgKm1zZ3MsCiAJCQkJZ290byBvdXQ7CiAJCQl9CiAJ
CQlyZXQgPSAtRUlPOworCQkJcHJfaW5mbygiJXM6IGlkLT5lcnJfc3RhdHVzPSUjeFxuIiwgX19m
dW5jX18sIGlkLT5lcnJfc3RhdHVzKTsKIAkJCWdvdG8gb3V0OwogCQl9CiAJfQo=
--001a11428a542dfe98055bcf0b77--
