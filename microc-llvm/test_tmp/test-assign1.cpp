// Generated by llvm2cpp - DO NOT MODIFY!

#include <llvm/Pass.h>
#include <llvm/PassManager.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/Analysis/Verifier.h>
#include <llvm/Assembly/PrintModulePass.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/InlineAsm.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/Support/FormattedStream.h>
#include <llvm/Support/MathExtras.h>
#include <algorithm>
using namespace llvm;

Module* makeLLVMModule();

int main(int argc, char**argv) {
  Module* Mod = makeLLVMModule();
  verifyModule(*Mod, PrintMessageAction);
  PassManager PM;
  PM.add(createPrintModulePass(&outs()));
  PM.run(*Mod);
  return 0;
}


Module* makeLLVMModule() {
 // Module Construction
 Module* mod = new Module("test-assign1.ll", getGlobalContext());
 
 // Type Definitions
 ArrayType* ArrayTy_0 = ArrayType::get(IntegerType::get(mod->getContext(), 8), 4);
 
 PointerType* PointerTy_1 = PointerType::get(ArrayTy_0, 0);
 
 std::vector<Type*>FuncTy_2_args;
 PointerType* PointerTy_3 = PointerType::get(IntegerType::get(mod->getContext(), 8), 0);
 
 FuncTy_2_args.push_back(PointerTy_3);
 FunctionType* FuncTy_2 = FunctionType::get(
  /*Result=*/IntegerType::get(mod->getContext(), 32),
  /*Params=*/FuncTy_2_args,
  /*isVarArg=*/true);
 
 std::vector<Type*>StructTy_4_fields;
 StructTy_4_fields.push_back(IntegerType::get(mod->getContext(), 32));
 StructTy_4_fields.push_back(IntegerType::get(mod->getContext(), 32));
 StructTy_4_fields.push_back(IntegerType::get(mod->getContext(), 32));
 StructTy_4_fields.push_back(PointerTy_3);
 StructType *StructTy_4 = StructType::get(mod->getContext(), StructTy_4_fields, /*isPacked=*/false);
 
 std::vector<Type*>FuncTy_5_args;
 FuncTy_5_args.push_back(PointerTy_3);
 FunctionType* FuncTy_5 = FunctionType::get(
  /*Result=*/StructTy_4,
  /*Params=*/FuncTy_5_args,
  /*isVarArg=*/true);
 
 std::vector<Type*>FuncTy_6_args;
 PointerType* PointerTy_7 = PointerType::get(StructTy_4, 0);
 
 FuncTy_6_args.push_back(PointerTy_7);
 FunctionType* FuncTy_6 = FunctionType::get(
  /*Result=*/IntegerType::get(mod->getContext(), 32),
  /*Params=*/FuncTy_6_args,
  /*isVarArg=*/true);
 
 std::vector<Type*>FuncTy_8_args;
 FuncTy_8_args.push_back(PointerTy_3);
 FuncTy_8_args.push_back(PointerTy_7);
 FunctionType* FuncTy_8 = FunctionType::get(
  /*Result=*/IntegerType::get(mod->getContext(), 32),
  /*Params=*/FuncTy_8_args,
  /*isVarArg=*/true);
 
 std::vector<Type*>FuncTy_9_args;
 FuncTy_9_args.push_back(IntegerType::get(mod->getContext(), 32));
 FuncTy_9_args.push_back(IntegerType::get(mod->getContext(), 32));
 FunctionType* FuncTy_9 = FunctionType::get(
  /*Result=*/StructTy_4,
  /*Params=*/FuncTy_9_args,
  /*isVarArg=*/true);
 
 std::vector<Type*>FuncTy_10_args;
 FunctionType* FuncTy_10 = FunctionType::get(
  /*Result=*/IntegerType::get(mod->getContext(), 32),
  /*Params=*/FuncTy_10_args,
  /*isVarArg=*/false);
 
 PointerType* PointerTy_11 = PointerType::get(IntegerType::get(mod->getContext(), 32), 0);
 
 PointerType* PointerTy_12 = PointerType::get(FuncTy_2, 0);
 
 
 // Function Declarations
 
 Function* func_printf = mod->getFunction("printf");
 if (!func_printf) {
 func_printf = Function::Create(
  /*Type=*/FuncTy_2,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/"printf", mod); // (external, no body)
 func_printf->setCallingConv(CallingConv::C);
 }
 AttributeSet func_printf_PAL;
 func_printf->setAttributes(func_printf_PAL);
 
 Function* func_load = mod->getFunction("load");
 if (!func_load) {
 func_load = Function::Create(
  /*Type=*/FuncTy_5,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/"load", mod); // (external, no body)
 func_load->setCallingConv(CallingConv::C);
 }
 AttributeSet func_load_PAL;
 func_load->setAttributes(func_load_PAL);
 
 Function* func_save = mod->getFunction("save");
 if (!func_save) {
 func_save = Function::Create(
  /*Type=*/FuncTy_6,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/"save", mod); // (external, no body)
 func_save->setCallingConv(CallingConv::C);
 }
 AttributeSet func_save_PAL;
 func_save->setAttributes(func_save_PAL);
 
 Function* func_save_file = mod->getFunction("save_file");
 if (!func_save_file) {
 func_save_file = Function::Create(
  /*Type=*/FuncTy_8,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/"save_file", mod); // (external, no body)
 func_save_file->setCallingConv(CallingConv::C);
 }
 AttributeSet func_save_file_PAL;
 func_save_file->setAttributes(func_save_file_PAL);
 
 Function* func_newpic = mod->getFunction("newpic");
 if (!func_newpic) {
 func_newpic = Function::Create(
  /*Type=*/FuncTy_9,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/"newpic", mod); // (external, no body)
 func_newpic->setCallingConv(CallingConv::C);
 }
 AttributeSet func_newpic_PAL;
 func_newpic->setAttributes(func_newpic_PAL);
 
 Function* func_delete_pic = mod->getFunction("delete_pic");
 if (!func_delete_pic) {
 func_delete_pic = Function::Create(
  /*Type=*/FuncTy_6,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/"delete_pic", mod); // (external, no body)
 func_delete_pic->setCallingConv(CallingConv::C);
 }
 AttributeSet func_delete_pic_PAL;
 func_delete_pic->setAttributes(func_delete_pic_PAL);
 
 Function* func_main = mod->getFunction("main");
 if (!func_main) {
 func_main = Function::Create(
  /*Type=*/FuncTy_10,
  /*Linkage=*/GlobalValue::ExternalLinkage,
  /*Name=*/"main", mod); 
 func_main->setCallingConv(CallingConv::C);
 }
 AttributeSet func_main_PAL;
 func_main->setAttributes(func_main_PAL);
 
 // Global Variable Declarations

 
 GlobalVariable* gvar_array_fmti = new GlobalVariable(/*Module=*/*mod, 
 /*Type=*/ArrayTy_0,
 /*isConstant=*/true,
 /*Linkage=*/GlobalValue::PrivateLinkage,
 /*Initializer=*/0, // has initializer, specified below
 /*Name=*/"fmti");
 
 GlobalVariable* gvar_array_fmts = new GlobalVariable(/*Module=*/*mod, 
 /*Type=*/ArrayTy_0,
 /*isConstant=*/true,
 /*Linkage=*/GlobalValue::PrivateLinkage,
 /*Initializer=*/0, // has initializer, specified below
 /*Name=*/"fmts");
 
 // Constant Definitions
 Constant *const_array_13 = ConstantDataArray::getString(mod->getContext(), "%d\x0A", true);
 Constant *const_array_14 = ConstantDataArray::getString(mod->getContext(), "%s\x0A", true);
 ConstantInt* const_int32_15 = ConstantInt::get(mod->getContext(), APInt(32, StringRef("1"), 10));
 ConstantInt* const_int32_16 = ConstantInt::get(mod->getContext(), APInt(32, StringRef("-1"), 10));
 std::vector<Constant*> const_ptr_17_indices;
 ConstantInt* const_int32_18 = ConstantInt::get(mod->getContext(), APInt(32, StringRef("0"), 10));
 const_ptr_17_indices.push_back(const_int32_18);
 const_ptr_17_indices.push_back(const_int32_18);
 Constant* const_ptr_17 = ConstantExpr::getGetElementPtr(gvar_array_fmti, const_ptr_17_indices);
 
 // Global Variable Definitions
 gvar_array_fmti->setInitializer(const_array_13);
 gvar_array_fmts->setInitializer(const_array_14);
 
 // Function Definitions
 
 // Function: main (func_main)
 {
  
  BasicBlock* label_entry = BasicBlock::Create(mod->getContext(), "entry",func_main,0);
  
  // Block entry (label_entry)
  AllocaInst* ptr_a = new AllocaInst(IntegerType::get(mod->getContext(), 32), "a", label_entry);
  StoreInst* void_19 = new StoreInst(const_int32_16, ptr_a, false, label_entry);
  LoadInst* int32_a1 = new LoadInst(ptr_a, "a1", false, label_entry);
  std::vector<Value*> int32_printf_params;
  int32_printf_params.push_back(const_ptr_17);
  int32_printf_params.push_back(int32_a1);
  CallInst* int32_printf = CallInst::Create(func_printf, int32_printf_params, "printf", label_entry);
  int32_printf->setCallingConv(CallingConv::C);
  int32_printf->setTailCall(false);
  AttributeSet int32_printf_PAL;
  int32_printf->setAttributes(int32_printf_PAL);
  
  ReturnInst::Create(mod->getContext(), const_int32_18, label_entry);
  
 }
 
 return mod;
}
