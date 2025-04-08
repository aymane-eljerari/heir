
// #include "openfhe/pke/openfhe.h"  // from @openfhe
#include <openfhe.h>
using namespace lbcrypto;
using CiphertextT = ConstCiphertext<DCRTPoly>;
using MutableCiphertextT = Ciphertext<DCRTPoly>;
using CCParamsT = CCParams<CryptoContextCKKSRNS>;
using CryptoContextT = CryptoContext<DCRTPoly>;
using EvalKeyT = EvalKey<DCRTPoly>;
using PlaintextT = Plaintext;
using PrivateKeyT = PrivateKey<DCRTPoly>;
using PublicKeyT = PublicKey<DCRTPoly>;

CiphertextT dot_product(CryptoContextT cc, CiphertextT ct, CiphertextT ct1);
CiphertextT dot_product__encrypt__arg0(CryptoContextT cc, std::vector<int16_t> v0, PublicKeyT pk);
CiphertextT dot_product__encrypt__arg1(CryptoContextT cc, std::vector<int16_t> v0, PublicKeyT pk);
int16_t dot_product__decrypt__result0(CryptoContextT cc, CiphertextT ct, PrivateKeyT sk);
CryptoContextT dot_product__generate_crypto_context();
CryptoContextT dot_product__configure_crypto_context(CryptoContextT cc, PrivateKeyT sk);
