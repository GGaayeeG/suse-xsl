<?xml version="1.0" encoding="UTF-8"?>
<!--
  Purpose:
    Logo SVG, chooses between color/grayscale mode itself.

  Author(s):  Stefan Knorr <sknorr@suse.de>,
              Thomas Schraitle <toms@opensuse.org>

  Copyright:  2013, 2021, Stefan Knorr, Thomas Schraitle

-->
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % fonts SYSTEM "fonts.ent">
  <!ENTITY % colors SYSTEM "colors.ent">
  <!ENTITY % metrics SYSTEM "metrics.ent">
  %fonts;
  %colors;
  %metrics;
]>
<xsl:stylesheet exclude-result-prefixes="d" version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template name="logo-image">
    <xsl:param name="geeko-color">
      <xsl:choose>
        <xsl:when test="$format.print != 1">&c_jungle;</xsl:when>
        <xsl:otherwise>&c_black;</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="logo-text-color">
      <xsl:choose>
        <xsl:when test="$format.print != 1">&c_pine;</xsl:when>
        <xsl:otherwise>&c_black;</xsl:otherwise>
      </xsl:choose>
    </xsl:param>

    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0" y="0" width="270" height="90" viewBox="0, 0, 270, 90">
      <path d="M238.462,55.726 L224.907,55.726 C223.862,55.726 223.011,54.876 223.011,53.83 L223.011,46.982 L236.095,46.982 C237.219,46.982 238.131,46.071 238.131,44.946 C238.131,43.821 237.219,42.909 236.095,42.909 L223.011,42.909 L223.011,36.17 C223.011,35.124 223.862,34.273 224.907,34.273 L238.462,34.273 C239.642,34.273 240.6,33.318 240.6,32.137 C240.6,30.957 239.642,30 238.462,30 L224.907,30 C221.507,30 218.738,32.767 218.738,36.17 L218.738,53.83 C218.738,57.232 221.507,59.999 224.907,59.999 L238.462,59.999 C239.642,59.999 240.6,59.044 240.6,57.864 C240.6,56.683 239.642,55.726 238.462,55.726 M198.602,42.965 C195.736,42.45 193.743,41.842 192.628,41.132 C191.511,40.423 190.953,39.466 190.953,38.259 C190.953,36.963 191.526,35.898 192.672,35.068 C193.819,34.24 195.433,33.824 197.516,33.824 C199.628,33.824 201.317,34.23 202.585,35.046 C203.267,35.485 203.888,36.068 204.448,36.798 C205.274,37.866 206.833,38.008 207.837,37.104 C208.784,36.25 208.867,34.786 208.015,33.836 C206.987,32.688 205.818,31.779 204.508,31.109 C202.561,30.113 200.215,29.616 197.471,29.616 C195.117,29.616 193.058,30.022 191.294,30.837 C189.529,31.651 188.177,32.753 187.243,34.14 C186.307,35.529 185.84,37.067 185.84,38.757 C185.84,40.356 186.208,41.713 186.949,42.829 C187.687,43.947 188.873,44.881 190.502,45.635 C192.13,46.39 194.317,47.023 197.063,47.536 C199.809,48.05 201.732,48.637 202.833,49.301 C203.935,49.965 204.485,50.839 204.485,51.924 C204.485,53.283 203.875,54.332 202.651,55.071 C201.431,55.81 199.748,56.18 197.606,56.18 C195.343,56.18 193.45,55.758 191.926,54.912 C191.056,54.429 190.277,53.789 189.587,52.992 C188.719,51.985 187.161,51.961 186.222,52.901 L186.214,52.911 C185.354,53.769 185.288,55.162 186.099,56.066 C188.681,58.948 192.533,60.388 197.651,60.388 C200.004,60.388 202.079,60.033 203.875,59.324 C205.67,58.616 207.063,57.598 208.059,56.271 C209.056,54.943 209.554,53.404 209.554,51.653 C209.554,50.025 209.192,48.66 208.468,47.559 C207.743,46.458 206.59,45.537 205.005,44.799 C203.422,44.059 201.287,43.448 198.602,42.965 M131.77,42.974 C128.904,42.459 126.913,41.85 125.797,41.141 C124.68,40.432 124.123,39.474 124.123,38.266 C124.123,36.97 124.696,35.906 125.842,35.077 C126.989,34.248 128.603,33.832 130.685,33.832 C132.795,33.832 134.486,34.24 135.753,35.054 C136.437,35.493 137.058,36.077 137.618,36.806 C138.442,37.876 140.002,38.017 141.006,37.113 C141.954,36.258 142.036,34.794 141.184,33.845 C140.156,32.696 138.986,31.787 137.677,31.117 C135.731,30.122 133.384,29.624 130.639,29.624 C128.286,29.624 126.227,30.031 124.463,30.845 C122.697,31.659 121.347,32.762 120.412,34.15 C119.477,35.537 119.009,37.075 119.009,38.765 C119.009,40.364 119.377,41.723 120.118,42.837 C120.857,43.954 122.042,44.891 123.67,45.644 C125.299,46.399 127.487,47.032 130.232,47.545 C132.977,48.058 134.9,48.647 136.002,49.31 C137.103,49.973 137.654,50.848 137.654,51.934 C137.654,53.292 137.043,54.34 135.822,55.079 C134.599,55.819 132.917,56.188 130.776,56.188 C128.512,56.188 126.618,55.766 125.095,54.92 C124.226,54.438 123.446,53.798 122.758,53.001 C121.89,51.993 120.331,51.97 119.39,52.911 L119.383,52.919 C118.523,53.777 118.457,55.17 119.268,56.074 C121.85,58.957 125.701,60.396 130.821,60.396 C133.174,60.396 135.248,60.042 137.043,59.333 C138.838,58.625 140.233,57.605 141.229,56.278 C142.225,54.952 142.722,53.411 142.722,51.662 C142.722,50.033 142.36,48.669 141.636,47.567 C140.911,46.465 139.759,45.546 138.173,44.807 C136.59,44.067 134.456,43.457 131.77,42.974 M176.343,32.059 L176.343,48.487 C176.343,52.408 175.302,55.372 173.221,57.379 C171.139,59.386 168.107,60.388 164.126,60.388 C160.142,60.388 157.11,59.386 155.028,57.379 C152.947,55.372 151.907,52.408 151.907,48.487 L151.907,32.059 C151.907,30.709 152.999,29.616 154.349,29.616 C155.698,29.616 156.794,30.709 156.794,32.059 L156.794,47.898 C156.794,50.735 157.389,52.824 158.581,54.166 C159.773,55.508 161.62,56.18 164.126,56.18 C166.63,56.18 168.476,55.508 169.668,54.166 C170.86,52.824 171.456,50.735 171.456,47.898 L171.456,32.059 C171.456,30.709 172.551,29.616 173.899,29.616 C175.249,29.616 176.343,30.709 176.343,32.059" fill="{$logo-text-color}"/>
      <path d="M101.408,42.16 C101.003,42.429 100.461,42.429 100.055,42.16 C99.391,41.719 99.327,40.797 99.863,40.264 C100.339,39.771 101.124,39.771 101.6,40.263 C102.135,40.797 102.07,41.719 101.408,42.16 M103.344,39.473 C104.116,42.757 101.164,45.71 97.88,44.938 C96.208,44.546 94.881,43.219 94.488,41.548 C93.718,38.266 96.669,35.315 99.952,36.084 C101.623,36.475 102.951,37.801 103.344,39.473 M81.232,57.135 C81.607,57.674 81.919,58.195 82.094,58.716 C82.218,59.086 82.377,59.574 82.742,59.77 C82.762,59.781 82.78,59.791 82.802,59.797 C83.472,60.041 85.195,60 85.195,60 L88.364,60 C88.635,60.004 91.016,59.997 90.956,59.731 C90.669,58.458 89.197,58.23 88.076,57.564 C87.043,56.948 86.063,56.25 85.619,55.049 C85.387,54.429 85.524,52.999 85.923,52.478 C86.214,52.101 86.643,51.851 87.104,51.75 C87.615,51.641 88.145,51.735 88.656,51.787 C89.286,51.851 89.908,51.965 90.536,52.043 C91.748,52.201 92.972,52.264 94.194,52.231 C96.211,52.175 98.233,51.854 100.145,51.202 C101.48,50.754 102.795,50.148 103.93,49.305 C105.22,48.346 104.881,48.436 103.573,48.57 C102.007,48.73 100.427,48.754 98.856,48.661 C97.39,48.576 95.944,48.403 94.618,47.722 C93.574,47.183 92.677,46.643 91.849,45.808 C91.725,45.682 91.648,45.314 91.875,45.079 C92.095,44.851 92.561,44.983 92.704,45.105 C94.148,46.312 96.302,47.306 98.532,47.414 C99.738,47.474 100.911,47.496 102.118,47.444 C102.721,47.416 103.631,47.42 104.236,47.414 C104.548,47.41 105.399,47.5 105.558,47.169 C105.606,47.073 105.602,46.962 105.598,46.854 C105.421,42.028 105.064,36.585 100.014,34.278 C96.246,32.555 90.597,29.886 88.211,28.779 C87.658,28.516 87.011,28.932 87.011,29.548 C87.011,31.16 87.093,33.476 87.094,35.584 C85.951,34.42 84.026,33.685 82.559,33.011 C80.893,32.247 79.173,31.599 77.423,31.054 C73.9,29.963 70.254,29.291 66.587,28.927 C62.428,28.512 58.199,28.711 54.104,29.557 C47.36,30.955 40.731,34.198 35.699,38.941 C32.61,41.851 30.186,45.988 30.022,50.187 C29.788,56.13 31.453,59.321 34.513,62.61 C39.393,67.852 49.896,68.586 54.15,62.37 C56.064,59.572 56.479,55.777 55.09,52.684 C53.701,49.593 50.508,47.359 47.123,47.245 C44.496,47.158 41.697,48.494 40.69,50.923 C39.922,52.778 40.359,55.07 41.758,56.51 C42.303,57.072 43.041,57.532 43.847,57.352 C44.322,57.246 44.719,56.889 44.791,56.407 C44.897,55.696 44.275,55.235 43.892,54.689 C43.201,53.704 43.341,52.225 44.206,51.388 C44.936,50.681 46.017,50.472 47.033,50.475 C47.979,50.477 48.946,50.646 49.762,51.123 C50.909,51.798 51.671,53.034 51.935,54.34 C52.722,58.243 49.549,61.414 45.247,61.663 C43.046,61.793 40.806,61.215 39.088,59.832 C34.737,56.332 33.671,49.178 38.644,45.359 C43.365,41.734 49.325,42.668 52.839,44.552 C55.651,46.059 57.747,48.525 59.335,51.251 C60.132,52.622 60.811,54.055 61.441,55.51 C62.047,56.909 62.614,58.319 63.827,59.344 C64.63,60.024 65.621,60 66.673,60 L72.678,60 C73.494,60 73.295,59.456 72.943,59.096 C72.147,58.282 71.003,58.098 69.944,57.807 C67.523,57.141 67.77,53.936 68.44,53.936 C70.604,53.936 70.672,54.001 72.568,53.977 C75.304,53.939 76.132,53.78 78.272,54.571 C79.416,54.995 80.515,56.113 81.232,57.135" fill="{$geeko-color}"/><!-- #30BA78 -->
    </svg>

  </xsl:template>

  <xsl:template name="secondary-branding">
   <!-- FIXME: NOOP for the moment, maybe there's a good new idea, the Geeko
   tail modeled on the old logo is certainly not that great anymore, so that is
   out.
   Not sure whether one of the stripes designs from the homepage or our
   desktop wallpapers should end up here, though if printed they would
   certainly eat up a lot of printer ink. Having real covers for once might
   also be cool, though 1. the printer ink issue remains, 2. they also
   increase file size, often by quite a bit, 3. the current glitch image
   style is a bit disappointing. -->
  </xsl:template>

</xsl:stylesheet>
